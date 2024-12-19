# Abyssum Protocol

Abyssum Protocol is a sentiment analysis web service that evaluates the emotional tone of text. It processes a given text input and returns whether the overall mood is positive, neutral, or negative. It is deployed in a Yandex Cloud environment, managed by Terraform and configured by Ansible, and runs inside a Docker container.

## Stack

- **Language:** Node.js  
- **Framework:** Express.js  
- **Library:** Sentiment (for natural language sentiment analysis)  
- **Containerization:** Docker  
- **Infrastructure as Code:** Terraform (Yandex Cloud)  
- **Configuration Management:** Ansible

## Requirements

- Terraform  
- Ansible  
- Yandex Cloud account and credentials  
- SSH key for accessing the instance

## Deployment Instructions

1. Update the `terraform/variables.tf` file with your Yandex Cloud credentials, cloud/folder IDs, zone, subnet ID, and image ID.
2. Navigate to the `terraform` directory and run:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```
   This will create a new Yandex Cloud instance and output its public IP address.

3. Update `ansible/inventory`:
   ```bash
   sed -i "s/<replace_with_public_ip>/$(terraform -chdir=../terraform output -raw web_public_ip)/" inventory
   ```

4. From the `ansible` directory, run:
   ```bash
   ansible-playbook -i inventory site.yml
   ```
   This will install Docker, start the container, and launch Abyssum.

## Usage

Once deployed, Abyssum Protocol listens on port 80. To analyze sentiment, send a GET request with a text query parameter:

```bash
curl "http://<PUBLIC_IP>/analyze?text=I+really+love+this+product"
```

Abyssum will return a JSON response with a sentiment score and overall mood.

### Example Response

```json
{
  "text": "I really love this product",
  "score": 3,
  "comparative": 0.75,
  "mood": "positive"
}
```

Replace `<PUBLIC_IP>` with the actual instance IP address obtained from Terraform’s output. You can integrate Abyssum Protocol into your applications, workflows, or scripts to gain insights into user feedback and improve decision-making based on textual sentiment analysis.

