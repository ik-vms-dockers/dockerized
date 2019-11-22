import os
import random
import time
import yaml


certbot_cmd = '/usr/local/bin/certbot'
certbot_config = yaml.safe_load(os.environ.get('CERTBOT_CONFIG'))
default_idle_time = 86400


with open('/etc/letsencrypt/cli.ini', 'w') as f:
  f.write(certbot_config['cli'])


for challenge in certbot_config['challenges']:
  with open('/etc/letsencrypt/{}.ini'.format(challenge), 'w') as f:
    f.write(certbot_config['challenges'][challenge])

  os.chmod('/etc/letsencrypt/{}.ini'.format(challenge), 0o400)

  with open('/etc/letsencrypt/cli.ini', 'a') as f:
    f.write('dns-{}-credentials = /etc/letsencrypt/{}.ini'.format(challenge, challenge))


for cert in certbot_config['certs']:
  print(cert)

  certbot_challenge = list(cert)[0]
  certbot_domains = '-d {}'.format(' -d '.join(cert[certbot_challenge]))

  if certbot_challenge != 'webroot':
    certbot_challenge = 'dns-{}'.format(certbot_challenge)

  os.system('{} certonly -n -q --agree-tos --register-unsafely-without-email --{} {}'.format(certbot_cmd, certbot_challenge, certbot_domains))


while True:
  idle_time = default_idle_time + random.randint(0, default_idle_time)
  print('Sleeping for {} seconds...'.format(idle_time))

  time.sleep(idle_time)
  os.system('{} renew'.format(certbot_cmd))
