# define: nginx::resource::shared_location
#
# This definition creates same location resources in multiple virtual hosts
# For more info about parameters look at nginx::resource::location
#
# Resulting locations will be named as $vhost-$name
#
# Actions:
#
# Requires:
#
# Sample Usage:
#  nginx::resource::shared_location { 'test2.local-bob':
#    ensure   => present,
#    www_root => '/var/www/bob',
#    location => '/bob',
#    vhosts   => ['test2.local',
#                 'test3.local'],
#  }
#
#  For other examples look at nginx::resource::location.

define nginx::resource::shared_location (
  $ensure               = present,
  $internal             = false,
  $location             = $name,
  $vhosts               = undef,
  $www_root             = undef,
  $autoindex            = undef,
  $index_files          = [
    'index.html',
    'index.htm',
    'index.php'],
  $proxy                = undef,
  $proxy_redirect       = $::nginx::config::proxy_redirect,
  $proxy_read_timeout   = $::nginx::config::proxy_read_timeout,
  $proxy_connect_timeout = $::nginx::config::proxy_connect_timeout,
  $proxy_set_header     = $::nginx::config::proxy_set_header,
  $fastcgi              = undef,
  $fastcgi_param        = undef,
  $fastcgi_params       = "${::nginx::config::conf_dir}/fastcgi_params",
  $fastcgi_script       = undef,
  $fastcgi_split_path   = undef,
  $uwsgi                = undef,
  $uwsgi_params         = "${nginx::config::conf_dir}/uwsgi_params",
  $ssl                  = false,
  $ssl_only             = false,
  $location_alias       = undef,
  $location_allow       = undef,
  $location_deny        = undef,
  $option               = undef,
  $stub_status          = undef,
  $raw_prepend          = undef,
  $raw_append           = undef,
  $location_custom_cfg  = undef,
  $location_cfg_prepend = undef,
  $location_cfg_append  = undef,
  $location_custom_cfg_prepend  = undef,
  $location_custom_cfg_append   = undef,
  $include              = undef,
  $try_files            = undef,
  $proxy_cache          = false,
  $proxy_cache_key      = undef,
  $proxy_cache_use_stale = undef,
  $proxy_cache_valid    = false,
  $proxy_method         = undef,
  $proxy_set_body       = undef,
  $auth_basic           = undef,
  $auth_basic_user_file = undef,
  $rewrite_rules        = [],
  $priority             = 500,
  $mp4             = false,
  $flv             = false,
) {
  validate_array($vhosts)
  $locations = parseyaml(inline_template("<% @vhosts.each do |vhost| %>
<%= vhost %>-<%= @name %>:
  vhost: <%= vhost %>
<% end %>"))
  create_resources('::nginx::resource::location', $locations, {
    ensure                      => $ensure,
    internal                    => $internal,
    location                    => $location,
    www_root                    => $www_root,
    autoindex                   => $autoindex,
    index_files                 => $index_files,
    proxy                       => $proxy,
    proxy_redirect              => $proxy_redirect,
    proxy_read_timeout          => $proxy_read_timeout,
    proxy_connect_timeout       => $proxy_connect_timeout,
    proxy_set_header            => $proxy_set_header,
    fastcgi                     => $fastcgi,
    fastcgi_param               => $fastcgi_param,
    fastcgi_params              => $fastcgi_params,
    fastcgi_script              => $fastcgi_script,
    fastcgi_split_path          => $fastcgi_split_path,
    uwsgi                       => $uwsgi,
    uwsgi_params                => $uwsgi_params,
    ssl                         => $ssl,
    ssl_only                    => $ssl_only,
    location_alias              => $location_alias,
    location_allow              => $location_allow,
    location_deny               => $location_deny,
    option                      => $option,
    stub_status                 => $stub_status,
    raw_prepend                 => $raw_prepend,
    raw_append                  => $raw_append,
    location_custom_cfg         => $location_custom_cfg,
    location_cfg_prepend        => $location_cfg_prepend,
    location_cfg_append         => $location_cfg_append,
    location_custom_cfg_prepend => $location_custom_cfg_prepend,
    location_custom_cfg_append  => $location_custom_cfg_append,
    include                     => $include,
    try_files                   => $try_files,
    proxy_cache                 => $proxy_cache,
    proxy_cache_key             => $proxy_cache_key,
    proxy_cache_use_stale       => $proxy_cache_use_stale,
    proxy_cache_valid           => $proxy_cache_valid,
    proxy_method                => $proxy_method,
    proxy_set_body              => $proxy_set_body,
    auth_basic                  => $auth_basic,
    auth_basic_user_file        => $auth_basic_user_file,
    rewrite_rules               => $rewrite_rules,
    priority                    => $priority,
    mp4                         => $mp4,
    flv                         => $flv,
  })
}

