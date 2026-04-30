
This is the KTA Run-Time Configuration Templates for various KTA server roles.

These files show role-specific runtime configuration settings.

See the 'Encrypted Config' subfolder for alternate configuration examples. This is WORK IN PROGRESS

INSTRUCTION
Use the config file for the appropriate role and adjust runtime settings as applicable before applying it to AKS.


kubectl create configmap ktawebapp-config --from-env-file=<path to .env file> --namespace kta
