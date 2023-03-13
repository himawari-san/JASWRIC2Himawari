# Copyright (C) 2022 Masaya YAMAGUCHI

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use utf8;
use MIME::Base64;
use 5.10.0;
    
binmode STDIN, ':utf8';
binmode STDOUT, ':raw:encoding(utf16le)';
binmode STDERR, ':utf8';


if(scalar(@ARGV) != 3){
    print STDERR "Invalid arguments error !!\nUsage: perl JASWRIC2Himawari.pl JASWRIC_Participant_Survey.txt JASWRIC_Tagged.txt Scanned > corpus.xml\n";
    exit;
}


my $tag_corpus = "JASWRIC";
my $tag_composition = "composition";
my $tag_sentence = "s";
my $tag_morph = "m";
my $corpus_name = "小中高大生による日本語絵描写ストーリーライティングコーパス(JASWRIC)";
my $ver="1.0";
my $image_file_suffix = ".jpg";
my $image_mine_type = "image/jpeg";

# Load a meta data file
my $filename = shift(@ARGV);
open(META, "<: encoding(utf16)", $filename) || die "Cannot open $filename\n";


my %metadata = ();

foreach(<META>){
    s/[\r\n]+$//;
    next if(/^Num\t/);

    my @w = split("\t");
    $metadata{$w[3]} = $_;
}


# Transform a tsv file to a XML file
$filename = shift(@ARGV);
open(TSV, "<: encoding(utf16)", $filename) || die "Cannot open $filename\n";
my $image_dir = shift(@ARGV);


print "\x{FEFF}"; # Put a BOM because Himawari XML files need it
print "<$tag_corpus name=\"$corpus_name\" ver=\"$ver\">\n";

my $prev_writer = "";
my $prev_boundary = "";
my $i_sentence = 0;
my $base64 = "";

foreach(<TSV>){
    s/[\r\n]+$//;
    next if(/^Seq\t/);

    my @w = split("\t");

    # new composition
    if($w[3] ne $prev_writer){
	# Put close tags except the first composition
	if($prev_writer ne ""){
	    print "</$tag_sentence>";
	    print "\n<img src=\"data:$image_mine_type;base64," . $base64 . "\" />\n" if($base64);
	    print "</$tag_composition>\n";
	    $base64 = "";
	}

	my @m = split("\t", $metadata{$w[3]});
	my $scanned = "$m[2]_$w[2]" . substr($w[3], 3) . $image_file_suffix;
	$i_sentence = 0;
	
	print "<$tag_composition writer=\"$w[3]\" topic=\"$w[2]\" grade=\"$m[1]\" grade_code=\"$m[2]\" read=\"$m[4]\" write=\"$m[5]\" age=\"$m[6]\" score=\"$m[7]\" scanned=\"$scanned\">\n";
	print "<$tag_sentence i=\"$i_sentence\">";
	$i_sentence++;
	$prev_writer = $w[3];

	if($scanned !~ /G13/){
	    open(IMG, "<", "$image_dir/$scanned") || die "Cannot open $image_dir/$scanned\n";
	    binmode(IMG);
	    my $img_data;
	    my $file_size = -s "$image_dir/$scanned";
	    read(IMG, $img_data, $file_size);
	    close(IMG);
	    $base64 = encode_base64($img_data, '');
	}
    }

    # new sentence
    if($w[5] eq "B"){
	print "</$tag_sentence>\n";
	print "<$tag_sentence i=\"$i_sentence\">";
	$i_sentence++;
    }

    # a:Seq, b:Grade, c:Topic, d:Writer, e:辞書, f:文境界, g:書字形（＝表層形）
    # h:語彙素, i:語彙素読み, j:品詞, k:活用型, l:活用形, m:発音形出現形, n:仮名形出現形
    # o:語種, p:書字形(基本形), q:語形(基本形)
    print "<$tag_morph a=\"$w[0]\" e=\"$w[4]\" g=\"$w[6]\" h=\"$w[7]\" i=\"$w[8]\" j=\"$w[9]\" k=\"$w[10]\" l=\"$w[11]\" m=\"$w[12]\" n=\"$w[13]\" o=\"$w[14]\" p=\"$w[15]\" q=\"$w[16]\">$w[6]</$tag_morph>";
}

print "</$tag_sentence>\n";
print "<img src=\"data:$image_mine_type;base64," . $base64 . "\" />\n" if($base64);
print "</$tag_composition>\n";
print "</$tag_corpus>\n";
