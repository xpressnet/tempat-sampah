#!/usr/bin/perl
# =====================================================
#     =  STORE-ID test  =
#	      
# =====================================================
$|=1;

while (<>) {
	@X = split;
#	$z = $X[0] . " ";

if ($X[1] =~ m/^https?\:\/\/.*youtube.*(ptracking|stream_204|player_204|gen_204).*(video_id|docid|v)\=([^\&\s]*).*/){
        $vid = $3 ;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
		$fn = "/var/log/squid3/@cpn";
		unless (-e $fn) {
			open FH,">".$fn ;
			print FH "$vid\n";
			close FH;
		} 
	print "ERR\n" ;

} elsif ($X[1] =~ m/^https?\:\/\/.*(youtube|google).*videoplayback.*/){
        @itag = m/[&?](itag=[0-9]*)/;
        @ids = m/[&?]id\=([^\&\s]*)/;
        @mime = m/[&?](mime\=[^\&\s]*)/;
        @cpn = m/[&?]cpn\=([^\&\s]*)/;
        if (defined($cpn[0])) {
            $fn = "/var/log/squid3/@cpn";
            if (-e $fn) {
                open FH,"<".$fn ;
                $id  = <FH>;
                chomp $id ;
                close FH ;
        	  } else {
                $id = $ids[0] ;
            }
        } else {
          $id = $ids[0] ;
        }
        @range = m/[&?](range=[^\&\s]*)/;
	print $X[0] . " OK store-id=http://googlevideo.squid.internal/id=" . $id . "&@itag@range@mime\n" ;



} elsif ($X[1] =~ m/^http:\/\/(videos|photos|scontent)[\-a-z0-9\.]*instagram\.com\/hphotos[\-a-z0-9]*\/([\w\d\-\_\/\.]*.(mp4|jpg))/){
	print $X[0] . " OK store-id=http://instagram.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^http:\/\/distilleryimage[\-a-z0-9\.]*instagram\.com\/(.*)/){
        print $X[0] . " OK store-id=http://instagram.squid.internal/$1\n" ;

} elsif ($X[1] =~ m/^https?:\/\/.*\.steampowered\.com\/depot\/[0-9]+\/chunk\/([^\?]*)/){
	print $X[0] . " OK store-id=http://steampowered.squid.internal/$1\n" ;

} elsif ($X[1] =~ m/^https?:\/\/.*(fbcdn|akamaihd)\.net\/.*\/(.*\.mp4)(.*)/) {
	print $X[0] . " OK store-id=storeurl://facebook.squid.internal/$2\n" ;

} elsif ($X[1] =~ m/^https?:\/\/.*(static|profile).*a\.akamaihd\.net(\/static-ak\/rsrc\.php\/v[0-9]\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)))/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*(static|profile).*\.ak\.fbcdn\.net(\/static-ak\/rsrc\.php\/v[0-9]\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)))/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*(static|profile).*a\.akamaihd\.net(\/rsrc\.php\/v[0-9]\/(.*))/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*(static|profile).*\.ak\.fbcdn\.net(\/rsrc\.php\/v[0-9]\/(.*))/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[^\/]*(fbcdn|akamaihd)[^\/]*net\/rsrc\.php\/(.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg))/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$2\n" ;

} elsif ($X[1] =~ m/^https?:\/\/[^\/]*(fbcdn|akamaihd)[^\/]*net\/safe\_image\.php\?.*(url\=.*\.(mp4|jpg|bmp|png|flv|m4v|gif|jpeg)).*/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/i[0-2].wp\.com\/graph\.facebook\.com\/(.*)/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(video\.ak\.fbcdn\.net)\/(.*?)\/(.*\.mp4)\??.*$/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$1/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/video\.(.*)\.fbcdn\.net\/(.*?)\/([0-9_]+\.(mp4|flv|avi|mkv|m4v|mov|wmv|3gp|mpg|mpeg)?)(.*)/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(fbcdn|scontent).*(akamaihd|fbcdn)\.net\/(h|s)(profile|photos).*\/((p|s).*\.(png|gif|jpg))(\?.+)?$/){
	print $X[0] . " OK store-id=http://facebook.squid.internal/$5\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(fbcdn|scontent).*(akamaihd|fbcdn)\.net\/(h|s)(profile|photos).*\/(.*\.(png|gif|jpg))(\?.+)?$/){
	print $X[0] . " OK store-id=http://facebook.squid.internal/$5\n" ;

} elsif ($X[1] =~ m/^https?:\/\/attachment\.fbsbx\.com\/.*\?(id=[0-9]*).*/) {
	print $X[0] . " OK store-id=http://facebook.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https:\/\/.*\.google\.com\/chrome\/win\/.+\/(.*\.exe)/){
	print $X[0] . " OK store-id=http://update-google.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.ytimg\.com\/(.*\.(webp|jpg|gif))/){
	print $X[0] . " OK store-id=http://ytimg.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*firedrive\.com\/download\/[0-9]+\/[0-9]+\/.*\?h=.*e\=.*f\=(.*)\&.*/){
	print $X[0] . " OK store-id=http://firedrive.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.4shared\.com\/.*\/dlink__[23]F([\w]+)_[23]F(.*)\_3Ftsid_[\w].*/){
	print $X[0] . " OK store-id=http://4shared.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.4shared\.com\/download\/([^\/]*).*/){
	print $X[0] . " OK store-id=http://4shared.squid.internal/$1\n" ;

} elsif ($X[1] =~ m/^https?:\/\/.*\.[a-z]+\.bing\.net\/(.*)\&w=.*/){
	print $X[0] . " OK store-id=http://bing.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.bing\.(net|com)\/.*\?id=([a-zA-Z]\.[0-9]+)&pid=.*/){
	print $X[0] . " OK store-id=http://bing.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.gstatic\.com\/images\?q=tbn\:(.*)/){
	print $X[0] . " OK store-id=http://gstatic.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.reverbnation\.com\/.*\/(ec_stream_song|download_song_direct|stream_song)\/([0-9]*).*/){
	print $X[0] . " OK store-id=http://reverbnation.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.dl\.sourceforge\.net\/(.*\.(exe|zip|mp3|mp4))/){
	print $X[0] . " OK store-id=http://sourceforge.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/fs[0-9]+\.filehippo\.com\/[^\/]*\/[^\/]*\/(.*)/){
	print $X[0] . " OK store-id=http://filehippo.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/download[0-9]+.mediafire\.com\/.*\/\w+\/(.*)/){
	print $X[0] . " OK store-id=http://mediafire.squid.internal$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*android\.clients\.google\.com\/[a-z]+\/[a-zA-Z]+\/[a-zA-Z]+\/(.*)\/([0-9]+)\?.*/){
	print $X[0] . " OK store-id=http://android.squid.internal/$1/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*(googleusercontent.com|blogspot.com)\/(.*)\/([a-z0-9]+)(-[a-z]-[a-z]-[a-z]+)?\/(.*\.(jpg|png))/){
	print $X[0] . " OK store-id=http://googleusercontent.squid.internal/$5\n" ;
} elsif ($X[1] =~ m/^https?:\/\/global-shared-files-[a-z][0-9]\.softonic\.com\/.{3}\/.{3}\/.*\/.*\=(.*\.exe)/){
	print $X[0] . " OK store-id=http://softonic.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*netmarble\.co\.id\/.*\/(data|ModooMarble)\/(.*)/){
	print $X[0] . " OK store-id=http://netmarble.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(.*)\.windowsupdate\.com\/(.*)\/(.*)\/([a-z].*)/){
	print $X[0] . " OK store-id=http://windowsupdate.squid.internal/$4\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*filetrip\.net\/.*\/((.*)\.([^\/\?\&]{2,4}))\?.*$/){
	print $X[0] . " OK store-id=http://filetrip.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*get4mobile\.net\/.*f=([^\/\?\&]*).*$/){
	print $X[0] . " OK store-id=http://get4mobile.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*thestaticvube\.com\/.*\/(.*)/){
	print $X[0] . " OK store-id=http://thestaticvube.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/113\.6\.235\.171\/youku\/.*\/(.*\.flv)/){
	print $X[0] . " OK store-id=http://youku.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/\d+\.\d+\.\d+\.\d+\/drama\/(.*\.mp4)\?.*\=(\d+)/){
	print $X[0] . " OK store-id=http://drama.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/([a-z])[\d]{1,2}?(.gstatic\.com.*|\.wikimapia\.org.*)/){
	print $X[0] . " OK store-id=http://gstatic.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.[a-z][0-9]\.(tiles\.virtualearth\.net)\/(.*\&n=z)/){
	print $X[0] . " OK store-id=http://virtualearth.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/imgv2-[0-9]\.scribdassets\.com\/(.*)/){
	print $X[0] . " OK store-id=http://scribdassets.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(.*?)\/(archlinux\/[a-zA-Z].*\/os\/.*)/){
	print $X[0] . " OK store-id=http://archlinux.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(.*?)\/speedtest\/(.*\.(jpg|txt))\??.*$/){
	print $X[0] . " OK store-id=http://speedtest.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/i[1-9]{3}\.photobucket\.com\/(.*)/){
	print $X[0] . " OK store-id=http://photobucket.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/i[1-9]{4}\.photobucket\.com\/(.*)/){
	print $X[0] . " OK store-id=http://photobucket.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/avideos\.5min\.com\/.*\/(.*)\?.*/){
	print $X[0] . " OK store-id=http://avideos.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.catalog\.video\.msn\.com\/.*\/(.*\.(mp4|flv|m4v))/){
	print $X[0] . " OK store-id=http://msn-video.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/v\.imwx\.com\/.*\/(.*)\?.*/){
	print $X[0] . " OK store-id=http://imwx.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/video[0-9]\.break\.com\/.*\/(.*)\?.*/){
	print $X[0] . " OK store-id=http://break.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.video[0-9]\.blip\.tv\/.*\/(.*)\?.*/){
	print $X[0] . " OK store-id=http://blip.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/ss[0-9]\.vidivodo\.com\/vidivodo\/vidservers\/server[0-9]*\/videos\/.*\/([a-zA-Z0-9.]*)\?.*/){
	print $X[0] . " OK store-id=http://vidivodo.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/video\-http\.media\-imdb\.com\/([a-zA-Z0-9\@\_\-]+\.(mp4|flv|m4v))\?.*/){
	print $X[0] . " OK store-id=http://imdb-video.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(vl|v)\.mccont\.com\/(.*)\/(.*\.(mp4|m4v|flv))\?.*/){
	print $X[0] . " OK store-id=http://mccont.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(vid.{0,2}|proxy.*)(\.ak|\.ec|\.akm|)\.(dmcdn\.net|dailymotion\.com)\/.*\/(frag.*\.(flv|mp4|m4v)).*/){
	print $X[0] . " OK store-id=http://dailymotion.squid.internal/$4\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.vimeo[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg|web))\?.*/){
	print $X[0] . " OK store-id=http://vimeo.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/fcache\.veoh\.com\/.*\/.*(l[0-9]*\.(mp4|flv))\?.*/){
	print $X[0] . " OK store-id=http://veoh.squid.internal$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/video\.thestaticvube\.com\/.*\/(.*)/){
	print $X[0] . " OK store-id=http://thestaticvube.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/cdn[0-9]\.videos\.videobash\.com\/.*\/(.*\.(mp4|m4v|flv))\?.*/){
	print $X[0] . " OK store-id=http://videobash.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.phncdn[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://phncdn.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.xvideos\.com\/.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://xvideos.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.tube8[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://tube8.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.(redtube|redtubefiles)\.com\/.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://redtube.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\/.*\/xh.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))/){
	print $X[0] . " OK store-id=http://xhcdn.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.xhcdn[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://xhcdn.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.nsimg[a-zA-Z0-9\-\_\.\%]*\.net.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://nsimg.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.youjizz\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://youjizz.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.public\.keezmovies[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://keezmovies.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.youporn[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://youporn.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.spankwire[a-zA-Z0-9\-\_\.\%]*\.com.*\/([a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://spankwire.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.pornhub[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://pornhub.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.us.playvid[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://playvid.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.slutload-media[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://slutload-media.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.hardsextube[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://hardsextube.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*\.public\.extremetube[a-zA-Z0-9\-\_\.\%]*\.com.*\/([[a-zA-Z0-9\-\_\.\%]*\.(flv|mp4|avi|mkv|mp3|rm|rmvb|m4v|mov|wmv|3gp|mpg|mpeg))\?.*/){
	print $X[0] . " OK store-id=http://extremetube.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/([a-z0-9.]*)(\.doubleclick\.net|\.quantserve\.com|.exoclick\.com|interclick.\com|\.googlesyndication\.com|\.auditude\.com|.visiblemeasures\.com|yieldmanager|cpxinteractive)(.*)/){
	print $X[0] . " OK store-id=http://ads.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/(.*?)\/(ads)\?(.*?)/){
	print $X[0] . " OK store-id=http://ads.squid.internal/$3\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9\-\_\.\%]*phobos\.apple\.com\/.*\/([a-zA-Z0-9\-\_\.\%]*\.ipa)/){
	print $X[0] . " OK store-id=http://apple.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/fs\w*\.fileserve\.com\/file\/(\w*)\/[\w-]*\.\/(.*)/){
	print $X[0] . " OK store-id=http://fileserve.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/s[0-9]*\.filesonic\.com\/download\/([0-9]*)\/(.*)/){
	print $X[0] . " OK store-id=http://filesonic.squid.internal/$2\n" ;
} elsif ($X[1] =~ m/^https?:\/\/download[0-9]{3}\.avast\.com\/(.*)/){
	print $X[0] . " OK store-id=http://avast.squid.internal/41\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[a-zA-Z0-9]+\.[a-zA-Z0-9]+x\.[a-z]\.avast\.com\/[a-zA-Z0-9]+x\/(.*\.vpx)/){
	print $X[0] . " OK store-id=http://avast.squid.internal\$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\/(iavs.*)/){
	print $X[0] . " OK store-id=http://iavs.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/.*\.starhub\.com\/[a-z]+\/[a-z]+\/[a-z]+\/(.*exe)\?[0-9]/){
	print $X[0] . " OK store-id=http://starhub.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/dnl-[0-9]{2}\.geo\.kaspersky\.com\/(.*)/){
	print $X[0] . " OK store-id=http://kaspersky.squid.internal/$1\n" ;
} elsif ($X[1] =~ m/^https?:\/\/([^\.]*)\.yimg\.com\/(.*)/){
	print $X[0] . " OK store-id=http://yimg.squid.internal/$1\n" ;
} else {
	print "ERR\n" ;
}
}
