# Configure the MySQL server from Puppetlabs module
class profile::monitor::librenms::mysql {

  $override_options = {
    'mysqld' => {
      'innodb_file_per_table' => 1,
      'sql-mode'              => '""',
    }
  }

  class { '::mysql::server':
    remove_default_accounts => true,
    override_options        => $override_options,
  }

}
