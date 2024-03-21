# Output diagnostic messages
#   You can print log messages, warnings, and fatal errors, which will
#   appear in the (Tiltfile) resource in the web UI. Tiltfiles support
#   multiline strings and common string operations such as formatting.
#
#   More info: https://docs.tilt.dev/api.html#api.warn
print("""
-----------------------------------------------------------------
✨ Hello Tilt! This appears in the (Tiltfile) pane whenever Tilt
   evaluates this file.
-----------------------------------------------------------------
""".strip())

load('ext://knative', 'knative_yaml', 'knative_install')

# custom build with jib
#custom_build(
#  'spring-boot-testcontainers',
#  './gradlew jibDockerBuild --image $EXPECTED_REF',
#  deps=['src'])

# custom build with paketo
custom_build(
  'dev.local/spring-boot-testcontainers',
  './gradlew bootBuildImage --imageName $EXPECTED_REF',
  deps=['src', 'build', 'config', 'config-local'],
  # Enables live reload
  live_update = [
    sync('./build/classes/java/main', '/workspace/BOOT-INF/classes')
  ])

k8s_custom_deploy(
  name='strimzi-kafka-operator',
  deps=[],
  apply_cmd='./config/install-strimzi-operator.sh',
  delete_cmd='./config/teardown-strimzi-operator.sh')



# knative extension increases default timeout to 5 mins
# because it's slow to tear down; in CI, where we're
# often more resource constrained, that's still too slow
# sometimes
update_settings(k8s_upsert_timeout_secs=60 * 7)

knative_install('v1.13.1')
k8s_custom_deploy(
  name='knative-kourier',
  deps=['knative-core'
  ],
  apply_cmd='./config/knative/install-kourier.sh',
  delete_cmd='./config/knative/teardown-kourier.sh')


k8s_yaml(['config/namespace.yml', 'config/postgresql-service.yml'])

k8s_yaml('config/kafka-service.yml')
k8s_kind('Kafka')
knative_yaml('config/testcontainers-service.yml')

# Manage
#k8s_resource('spring-boot-testcontainers', port_forwards=['8080:8080', '9000:9000'])



# Extensions are open-source, pre-packaged functions that extend Tilt
#
#   More info: https://github.com/tilt-dev/tilt-extensions
#
load('ext://git_resource', 'git_checkout')
