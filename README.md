# aws-homelab


![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/91fae44b-7086-473e-b1ee-17305f034136)


## Some starting configuration after setting up the config files

### To start Terraform : ``` terraform init ```
![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/b44de944-86a3-41c6-9ae5-bc1c2117b4c5)


### Plan on how to configure Terraform : ``` terraform plan ```
![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/ce8dc62a-dab7-4b2a-9bee-371fbfb8974a)

### State what public key was created in EC2 : ``` terraform apply -var="aws-key=name_of_key" ```
![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/3724d11e-ffa8-4afa-a704-61ac8eece76b)



## The running EC2 instances - Kali machine (attacker)
![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/566e2445-e0af-4f2b-b054-a56ffa1fa290)

### Some commands used during Kali setup: upgrade, update, setup RDP  
``` echo "[i] Updating and upgrading Kali"
apt-get update
apt-get full-upgrade -y
apt-get install -y kali-desktop-xfce xorg xrdp

echo "[i] Configuring xrdp to listen to port 3389 (but not starting the service)"
sed -i 's/port=3389/port=3389/g' /etc/xrdp/xrdp.ini
```
```
systemctl enable xrdp --now
```

![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/023670d8-83d8-47d0-b341-26750c97dc1f)


![image](https://github.com/KurapikaLeo/aws-homelab/assets/101999591/b9d27da2-b7c6-4e12-8abf-ae01103da462)

