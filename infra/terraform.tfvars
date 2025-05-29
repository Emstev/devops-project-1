bucket_name = "cba-proj-1-jenkins-remote-state-bucket"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDomqQbEF22CDpL0Mt28P5GQ4PGqCmUDnkwcpk+7/MI+ZeJKg+E3mHY8xuNzz/UTMDMhkVEU+EgZX0ZNvW6+ROZbg1SesBkV3aYMkq4gXcq2ooR7kNsEoQ205sWiwEAlbAh40TBMshObkAtSw5DZFtK6t7iqOY3l84QhG9noQjHf4W+EGG0mtjojbQM2nvlydu9F7GrMFUouP1uSn1k1/kNwW3JTyG38cboqXOkL4iK41gUGtdGzwxr/FzrGGpCEzhmTs2BeJD1qEZHxGzNUJ8eBHxu/zFPcC16IaI448N5cfb0plVUUA7i6vmTxiqv2ge8jEaQ15Y7LFnRHoTtdY0vmaWVyBxtt+RA9vPqmX7hqz3ztap3JVCHwyuYasuhMP1jfir+Z9W+5SKitO0vMQG8T2D22iAGC7iAc5P4Ryety8sSqsA3d4bg8lwrkuhteA56nDvRKoDu8XVecbCSyy3xvCqBAF1LEVfWWrRXl2CCBpe3cPl+xnn/ERdQOoJyRvU= emmanuelekwonu@Mac.lan" #Replace with your public key
ec2_ami_id     = "ami-03250b0e01c28d196"

ec2_user_data_install_apache = ""

domain_name = "cbaflaskapp.website"
