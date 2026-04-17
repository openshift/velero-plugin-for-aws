FROM brew.registry.redhat.io/rh-osbs/openshift-golang-builder:rhel_9_golang_1.25 AS builder

COPY . /workspace
WORKDIR /workspace/
ENV GOEXPERIMENT strictfipsruntime
RUN CGO_ENABLED=1 GOOS=linux go build -v -mod=mod -tags strictfipsruntime -o /workspace/bin/velero-plugin-for-aws ./velero-plugin-for-aws

FROM registry.redhat.io/ubi9/ubi:latest
RUN dnf -y install openssl && dnf -y reinstall tzdata && dnf clean all
RUN mkdir /plugins
COPY --from=builder /workspace/bin/velero-plugin-for-aws /plugins/
COPY --from=builder /workspace/LICENSE /licenses/
USER nobody:nogroup
ENTRYPOINT ["/bin/bash", "-c", "cp /plugins/* /target/."]

LABEL description="OpenShift API for Data Protection - Velero Plugin for AWS"
LABEL io.k8s.description="OpenShift API for Data Protection - Velero Plugin for AWS"
LABEL io.k8s.display-name="OADP Velero Plugin for AWS"
LABEL io.openshift.tags="migration"
LABEL summary="OpenShift API for Data Protection - Velero Plugin for AWS"
