#############################################
# Tests for Sysadm::Install/s slurp/blurt/pie
#############################################

use Test::More tests => 3;

use Sysadm::Install qw(:all);

use File::Spec;
use File::Path;

my $TEST_DIR = ".";
$TEST_DIR = "t" if -d 't';

#####################################################################
# Create a temp file
#####################################################################
my $TMP_FILE = File::Spec->catfile($TEST_DIR, "test.dat");
END { unlink $TMP_FILE }

#####################################################################
# Blurt
#####################################################################
blurt("one\ntwo\nthree", $TMP_FILE);
ok(-f $TMP_FILE, "$TMP_FILE exists");

#####################################################################
# Slurp
#####################################################################
my $data = slurp($TMP_FILE);
is($data, "one\ntwo\nthree", "$TMP_FILE contains right data");

#####################################################################
# pie
#####################################################################
pie( sub { s/three/four/g; $_; }, $TMP_FILE );
$data = slurp($TMP_FILE);
is($data, "one\ntwo\nfour", "$TMP_FILE got pied");