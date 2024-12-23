FROM registry.access.redhat.com/ubi9/ubi:9.4

# Install binary packages
RUN dnf update -y && \
    dnf install -y git tar ca-certificates gzip zip unzip jq openssh-clients gettext && \
    dnf clean all

# Install gh command
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo && \
    dnf install -y gh --repo gh-cli

# Install AWS CLI package
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.15.34.zip" -o "/root/awscliv2.zip" && \
    unzip -d /root "/root/awscliv2.zip" && \
    /root/aws/install && \
    rm -rf awscliv2.zip aws/

# Install ROSA CLI
RUN curl -kLO https://mirror.openshift.com/pub/openshift-v4/clients/rosa/latest/rosa-linux.tar.gz && \
    tar xzf rosa-linux.tar.gz && \
    mv rosa /usr/local/bin/rosa && \
    chmod +x /usr/local/bin/rosa ##&& \
#   rosa download oc && \
#   tar xzf openshift-client-linux.tar.gz && \
#   mv oc kubectl /usr/local/bin/ && \
#   rm -rf rosa-linux.tar.gz openshift-client-linux.tar.gz

# Install GitHub CLI package
#RUN curl -L -o - https://github.com/cli/cli/releases/download/v2.40.1/gh_2.40.1_linux_amd64.tar.gz | tar xzf - -O gh_2.40.1_linux_amd64/bin/gh > /usr/local/bin/gh && \
#    chmod 755 /usr/local/bin/gh

# Install Helm package
RUN curl -kLO https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-amd64.tar.gz && \
    tar xzf helm-linux-amd64.tar.gz && \
    mv helm-linux-amd64 /usr/local/bin/helm && \
    rm -rf helm-linux-amd64.tar.gz

# Install Terraform
RUN dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo && \
    dnf -y install terraform
