export SHA1="eddef044114a1d629b1d7886a89d4c9d222105ec"
export SHA256="5a52c955db20f017a213838e6fb45af029c0e67e7e28d5fd7aca23cbec24d543"
export FILENAME="chef-18.2.7-1.el7.x86_64.rpm"
export LICENSE_ID="83f657b6-bfec-4154-bf99-02cf2fcd114e"
curl -L "https://commercial-acceptance.downloads.chef.co/stable/chef/download?p=amazon&pv=2&m=x86_64&v=18.2.7&license_id=$LICENSE_ID" --output $FILENAME
export SHA1_CHECK=$(echo -n "$SHA1 $FILENAME" | sha1sum -c)
export SHA256_CHECK=$(echo -n "$SHA256 $FILENAME" | sha256sum -c)
echo "SHA1 check $SHA1_CHECK"
echo "SHA256 check $SHA256_CHECK"