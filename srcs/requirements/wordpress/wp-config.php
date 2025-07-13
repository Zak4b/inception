<?php
define( 'DB_NAME', 'inception' );
/** Database username */
define( 'DB_USER', 'user' );
/** Database password */
define( 'DB_PASSWORD', '123' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8mb4' );
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '$H*eK7_>oJfV*EQhsJu=zg2<o&k[n?qAxh^BgniXFQ4;|5(#sB+-zxz[fZ7)hrAY' );
define( 'SECURE_AUTH_KEY',  'o,iY4w{5J`U[jOYA)IH$1=N{iHxAG,DQz+USS)@UCC:ysCxK[4l -AU%uXZ=V>;_' );
define( 'LOGGED_IN_KEY',    '?dgNsbGLP{ku7]c}$Do9`aq6d4h$o9U}ZI7/N`#]qd(9 %y|K dM-K%^U:s0S6E~' );
define( 'NONCE_KEY',        '8nL9o&]- .hYy,#?1.+hK/8xXh_En{<w:`04+Ut4D@I#}l.ME-m&P6$</tU+<}pT' );
define( 'AUTH_SALT',        'bPLh/1`q8bZ$}%^tL,5W^)EiSzveAB0h1LbR3RCuD$v3]99FKgQA8D0~A1F8/z;u' );
define( 'SECURE_AUTH_SALT', 'E%@{4b.i7AC_q]65,9KDNZ+?e]UTm*#aa(ho.^MgeBh(Wm*Ch5[!i5S|;d^yMq(d' );
define( 'LOGGED_IN_SALT',   'Xf wF_f@7=Iwb]}HwNR/cfg{e.-CnM Ru3Z|:?=)pk/iBJBOe:4xT_!b[ZZl^(w)' );
define( 'NONCE_SALT',       'S`d%=yy*asn1#o[,!JT0VjRjxd_0>_eV%RWutJg>Q74MSZHfN.6k/sC@;!OWaXX!' );

/**#@-*/
$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
