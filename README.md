# terraform
A repo containing my ready to use TF code snippets.
It'll create EC2 instance with Postgres DB installed along with some supporting AWS components like Key Pair, S3 bucket etc.

Step 1: Generate ssh keys for EC2 and store those inside ssh-keys folder of this repo
```
PS D:\Study\terraform\aws\terraform> ssh-keygen -t ed25519                            
Generating public/private ed25519 key pair.
Enter file in which to save the key (C:\Users\apamo/.ssh/id_ed25519): D:\Study\terraform\aws\terraform\ssh-keys\id_ed25519                               
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in D:\Study\terraform\aws\terraform\ssh-keys\id_ed25519
Your public key has been saved in D:\Study\terraform\aws\terraform\ssh-keys\id_ed25519.pub
The key fingerprint is:
SHA256:G4g7yqi0pkrRmsXRF9Qz8kfVKQKtuhUCEqWWb4D7tM8 apamo@AB-LA
The key's randomart image is:
+--[ED25519 256]--+
|   .o..o..o ... .|
|  ..+. ..+ + . o |
| . *....o = . .  |
|  = +..o + .     |
| o =.o. S o      |
|  B o. . +       |
| = oo   +        |
|o+..o. .         |
|X.o  E           |
+----[SHA256]-----+                           

```

Step 2: Copy public key of generated ssh into terraform.auto.tfvars

Step 3: Add your A cloud guru temporary AWS credentials (access key id & secret access key) in terraform.auto.tfvars

Step 4: Initialize TF
```
terraform init
```

Step 5: Generate TF plan
```
terraform plan

```

Step 6: Apply the TF plan
```
terraform apply --auto-approve
```