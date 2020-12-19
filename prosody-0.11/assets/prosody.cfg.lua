-- Prosody Example Configuration File
--
-- Information on configuring Prosody can be found on our
-- website at http://prosody.im/doc/configure
--
-- Tip: You can check that the syntax of this file is correct
-- when you have finished by running: luac -p prosody.cfg.lua
-- If there are any errors, it will let you know what and where
-- they are, otherwise it will keep quiet.
--

daemonize = false

-- Interfaces to listen on
-- We are setting the ifaces to only listen on IPv4 addresses
interfaces = "*"
component_interface = "*"
local_interfaces = "127.0.0.1"


---------- Server-wide settings ----------
-- Settings in this section apply to the whole server and are the default settings
-- for any virtual hosts

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = false;

-- These paths are searched in the order specified, and before the default path
plugin_paths = { "/usr/local/lib/prosody-community-modules" }

-- This is the list of modules Prosody will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {

	-- Generally required
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections
		"dialback"; -- s2s dialback support
		"disco"; -- Service discovery

	-- Not essential, but recommended
		"private"; -- Private XML storage (for room bookmarks, etc.)
		"vcard4";
		"vcard_legacy";

	-- Nice to have
		"version"; -- Replies to server version requests
		"uptime"; -- Report how long server has been running
		"time"; -- Let others know the time here on this server
		"ping"; -- Replies to XMPP pings with pongs
		"pep"; -- Enables users to publish their mood, activity, playing music and more
		"register"; -- Allow users to register on this server using a client and change passwords

	-- Admin interfaces
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		--"admin_telnet"; -- Opens telnet console interface on localhost port 5582

	-- HTTP modules
		"http_files"; -- Serve static files from a directory over HTTP
		"http_libjs"; -- Serve static files from a directory over HTTP
		--"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"

	-- Other specific functionality
		"watchregistrations"; -- Alert admins of registrations
		--"groups"; -- Shared roster support
		--"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		--"announce"; -- Send announcement to all online users
		--"welcome"; -- Welcome users who register accounts
		--"motd"; -- Send a message to users when they log in
		--"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.

	-- Community Modules
		"admin_blocklist";
		"admin_web";
        "blocking";
        "carbons";
        "cloud_notify";
        "csi";
        "http_upload";
        "mam";
		"password_reset";
        "privacy_lists";
        "smacks";
};

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:
modules_disabled = {
	-- "offline"; -- Store offline messages
	-- "c2s"; -- Handle client connections
	-- "s2s"; -- Handle server-to-server connections
};

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false
min_seconds_between_registrations = 600

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
--ssl = {
--	key = "/usr/local/etc/prosody/certs/localhost.key";
--	certificate = "/usr/local/etc/prosody/certs/localhost.crt";
--}

-- Force clients to use encrypted connections? This option will
-- prevent clients from authenticating unless they are using encryption.

c2s_require_encryption = false

-- Force certificate authentication for server-to-server connections?
-- This provides ideal security, but requires servers you communicate
-- with to support encryption AND present valid, trusted certificates.
-- NOTE: Your version of LuaSec must support certificate verification!
-- For more information see http://prosody.im/doc/s2s#security

s2s_secure_auth = false

-- Many servers don't support encryption or have invalid or self-signed
-- certificates. You can list domains here that will not be required to
-- authenticate using certificates. They will be authenticated using DNS.

--s2s_insecure_domains = { "gmail.com" }

-- Even if you leave s2s_secure_auth disabled, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

-- Select the authentication backend to use. The 'internal' providers
-- use Prosody's configured data storage to store the authentication data.
-- To allow Prosody to offer secure authentication mechanisms to clients, the
-- default provider stores passwords in plaintext. If you do not trust your
-- server please see http://prosody.im/doc/modules/mod_auth_internal_hashed
-- for information about using the hashed backend.

authentication = "internal_hashed"

-- Select the storage backend to use. By default Prosody uses flat files
-- in its configured data directory, but it also supports more backends
-- through modules. An "sql" backend is included by default, but requires
-- additional dependencies. See http://prosody.im/doc/storage for more info.

default_storage = "internal" -- Default is "internal"
storage = {
    archive2 = "xmlarchive";
    muc_log = "xmlarchive";
}

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = {
	info = "/dev/stdout"; -- Change 'info' to 'debug' for verbose logging
	-- "*console";
}

-- Configure Message Archive
archive_expires_after = "2m"

-- Set SSL Certs, we assume one certificate with subject-alternative-names for
-- all components; else, seperate ssl configs inside the components will be
-- needed.
--https_ssl = {
--        key = "certs/example.key";
--        certificate = "certs/fullchain.cer";
--    }
--ssl = {
--        key = "certs/example.key";
--        certificate = "certs/fullchain.cer";
--}

-- Logging for MUCs
muc_log_by_default = true; -- Enable logging by default (can be disabled in room config)
muc_log_all_rooms = false; -- set to true to force logging of all rooms
max_history_messages = 20;

-- Common htp server for static files
http_files_dir = "/usr/local/var/lib/www";
libjs_path = "/usr/local/var/lib/javascript";

----------- Virtual hosts -----------
-- You need to add a VirtualHost entry for each domain you wish Prosody to serve.
-- Settings under each VirtualHost entry apply *only* to that host.
VirtualHost "example.com"

------ Components ------
-- You can specify components to add hosts that provide special services,
-- like multi-user conferences, and transports.
-- For more information on components, see http://prosody.im/doc/components

---Set up a MUC (multi-user chat) room server on conference.example.com:
Component "conference.example.com" "muc"
	modules_enabled = {
		"muc_mam";
		"remote_roster";
		"vcard_muc";
	}

-- Set up a bytestream proxy for server-proxied file transfers:
Component "proxy65.example.com" "proxy65"
	proxy65_acl = {
		'example.com',
    };


---Set up an external component (default component port is 5347)
--
-- External components allow adding various services, such as gateways/
-- transports to other networks like ICQ, MSN and Yahoo. For more info
-- see: http://prosody.im/doc/components#adding_an_external_component
--
--Component "gateway.example.com"
--	component_secret = "password"
