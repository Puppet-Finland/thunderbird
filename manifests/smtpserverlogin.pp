#
# == Define: thunderbird::smtpserverlogin
#
# Set up login details for a particular user and a particular SMTP server.
#
define thunderbird::smtpserverlogin
(
    $username,
    $smtpserver,
    $smtpserver_username,
)
{

    include os::params
    include thunderbird::params

    $id = $smtpserver

    concat::fragment { "thunderbird-user.js-${username}-smtpserverlogin-${id}":
        target => "thunderbird-user.js-${username}",
        content => template('thunderbird/smtpserverlogin.js.erb'),
        owner => $username,
        mode => $::thunderbird::params::file_perms,
    }
}