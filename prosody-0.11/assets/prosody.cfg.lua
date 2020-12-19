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

-- #######################################################
-- # Global Settings                                     #
-- # Settings in this section apply to the whole server  #
-- # and are the default settings for any virtual hosts  #
-- #######################################################

----------------------
-- Server Settings  --
----------------------
daemonize = false

-- Interfaces to listen on
-- We are setting the ifaces to only listen on IPv4 addresses
interfaces = "*"
component_interface = "*"
local_interfaces = "127.0.0.1"

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see http://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
-- TODO: Add your admin-user here
--admins = { }

-- Enable use of libevent for better performance under high load
-- For more information see: http://prosody.im/doc/libevent
use_libevent = false;

-- These are the SSL/TLS-related settings. If you don't want
-- to use SSL/TLS, you may comment or remove this
-- We assume one certificate with subject-alternative-names for
-- all components; else, seperate ssl configs inside the components will be
-- needed.
--TODO: Configure this or you will regret it!
--https_ssl = {
--        key = "certs/example.key";
--        certificate = "certs/fullchain.cer";
--    }
--ssl = {
--        key = "certs/example.key";
--        certificate = "certs/fullchain.cer";
--}

-- Logging configuration
-- For advanced logging see http://prosody.im/doc/logging
log = {
	info = "/dev/stdout"; -- Change 'info' to 'debug' for verbose logging
	-- "*console";
}

-- Common http server for static files
http_files_dir = "/usr/local/var/lib/www";
libjs_path = "/usr/local/var/lib/javascript";

--------------------
-- Select Modules --
--------------------
-- These paths are searched in the order specified, and before the default path
plugin_paths = { "/usr/local/lib/prosody-community-modules" }

-- This is the list of modules Prosody will load on startup.
-- It looks for mod_modulename.lua in the plugins folder, so make sure that exists too.
-- Documentation on modules can be found at: http://prosody.im/doc/modules
modules_enabled = {
	-- Generally required
		"roster";    -- Allow users to have a roster. Recommended ;)
		"saslauth";  -- Authentication for clients and servers. Recommended if you want to log in.
		"dialback";  -- s2s dialback support
		"disco";     -- Service discovery
		-- TODO: Enable TLS once you have certificates
		--"tls";       -- Add support for secure TLS on c2s/s2s connections

	-- Not essential, but recommended
	    "carbons";
        "csi_simple";
		"pep";
		"private";   -- Private XML storage (for room bookmarks, etc.)
		"vcard4";
		"vcard_legacy";

	-- Nice to have
		"version";   -- Replies to server version requests
		"uptime";    -- Report how long server has been running
		"time";      -- Let others know the time here on this server
		"ping";      -- Replies to XMPP pings with pongs
		"register";  -- Allow users to register on this server using a client and change passwords
		"register_ibr";
        "mam";

	-- Admin interfaces
		"admin_adhoc";    -- Allows administration via an XMPP client that supports ad-hoc commands
		--"admin_telnet"; -- Opens telnet console interface on localhost port 5582

	-- HTTP modules
	    "websocket";
		"http_files";             -- Serve static files from a directory over HTTP
		"http_libjs";             -- Serve static files from a directory over HTTP
		"http_host_status_check";
		--"bosh";                 -- Enable BOSH clients, aka "Jabber over HTTP"

	-- Other specific functionality
		"watchregistrations";  -- Alert admins of registrations
		"announce";            -- Send announcement to all online users
		"server_contact_info";
		--"groups";            -- Shared roster support
		--"posix";             -- POSIX functionality, sends server to background, enables syslog, etc.
		--"welcome";           -- Welcome users who register accounts
		--"motd";              -- Send a message to users when they log in
		--"legacyauth";        -- Legacy authentication. Only used by some old clients and bots.

	-- Community Modules
		"admin_blocklist";
		"admin_web";
        "blocking";
		"bookmarks";
        "cloud_notify";
		"password_reset";
        "privacy_lists";
        "smacks";
		"s2s_keepalive";
		-- "turncredentials";
};

-- Disable account creation by default, for security
-- For more information see http://prosody.im/doc/creating_accounts
allow_registration = false
min_seconds_between_registrations = 600

-------------------------
-- Connection Settings --
-------------------------
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

----------------------
-- Storage Settings --
----------------------
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

-----------------------------
-- Some messaging settings --
-----------------------------

-- TODO: Provide some contact information
contact_info = {
  abuse = { "mailto:abuse@example.com", "https://example.com/contact" };
  admin = { "https://exapmle.com/contact" };
  feedback = { "https://exapmle.com/contact" };
  security = { "https://exapmle.com/contact" };
  support = { "https://exapmle.com/contact" };
  sales = { "https://exapmle.com/contact" };
};

-- Configure Message Archive
archive_expires_after = "2m"

-- Logging for MUCs
muc_log_by_default = true; -- Enable logging by default (can be disabled in room config)
muc_log_all_rooms = false; -- set to true to force logging of all rooms
max_history_messages = 20;

-- STUN/TURN Server
--turncredentials_secret = "XXXXXXXXXXXXXXXXX";
--turncredentials_host   = "external.turn.server.exmple.com";
--turncredentials_port   = 8080;
--turncredentials_ttl    = 86400;

-- #######################################################
-- # Virtual hosts                                       #
-- # You need to add a VirtualHost entry for each domain #
-- # you wish Prosody to serve.                          #
-- # Settings under each VirtualHost entry apply *only*  #
-- # to that host.                                       #
-- #######################################################
VirtualHost "example.com"

-- #######################################################
-- # Components                                          #
-- # You can specify components to add hosts that        #
-- # provide special services, like multi-user           #
-- # conferences, and transports.                        #
-- # For more information on components, see             #
-- # http://prosody.im/doc/components                    #
-- #######################################################

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

Component "xmppfiles.example.com" "http_upload"
    http_upload_file_size_limit = 5 * 1024 * 1024  -- 5 MB
    http_upload_expire_after = 60 * 60 * 24 * 30   -- 30 Tage
    http_upload_quota = 50 * 1024 * 1024           -- 50 MB

---Set up an external component (default component port is 5347)
--
-- External components allow adding various services, such as gateways/
-- transports to other networks like ICQ, MSN and Yahoo. For more info
-- see: http://prosody.im/doc/components#adding_an_external_component
--
--Component "gateway.example.com"
--	component_secret = "password"
