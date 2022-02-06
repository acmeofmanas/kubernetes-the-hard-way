ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

#distrbute
for instance in master-1 master-2; do
  scp encryption-config.yaml ${instance}:~/
done

#move to destination directory
for instance in master-1 master-2; do
  ssh ${instance} mkdir -p /var/lib/kubernetes/; mv encryption-config.yaml /var/lib/kubernetes/
done

