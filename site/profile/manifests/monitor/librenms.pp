# Include the LibreNMS configuration modules
# and assosciated features
class profile::monitor::librenms {

  include librenms
  include librenms::nginx

  mysql::db { 'librenms_database':
    user     => 'librenms',
    password => 'V|[@7N^]}iepGRUsj"!,%2kgY%#S|,MbVvwy6rF[klatM7{f0',
    dbname   => 'librenms',
    host     => 'localhost',
    grant    => ['ALL'],
    charset  => 'utf8',
    collate  => 'utf8_unicode_ci',
  }

}
