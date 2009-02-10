// Settings
window.jsblock = {
	'v' : {
		'blocked':false, // report blocked srcipts found
		'suspects':true, // report suspected scripts found
		'externals':true, // report external scripts found
		'blockGoogle':true // google is usually nice. their tracker does not track between sites and their scripts are very fast.
	}
}; 
// Blacklist:
jsblock.list = [
	'a.tribalfusion.com/j.ad',
	'ad.doubleclick.net/adj',
	'ad.no.doubleclick.net/adj',
	'adserver.adtech.de',
	'adsremote.scripps.com',
	'annonser.dagbladet.no',
	'basefarm.net/RealMedia/ads',
	'advertising.com/wrapper/aceUAC.js',
	'core.insightexpressai.com/adServer/',
	'edge.quantserve.com/quant.js', // did some cookie stuff. dunno what it is but it's probably a tracker
	'googleads.g.doubleclick.net/pagead/test_domain.js',
	'hstno.tradedoubler.com',
	'js.adsonar.com',
	'o.aolcdn.com/ads/adsWrapper.js',
	'oascentral.dilbert.com/RealMedia/ads',
	'st.sageanalyst.net',
	'track.adform.net'
];

//
// Do not change below here unless you know what you are doing
//
jsblock.exrx = new RegExp('^http:\/\/([a-zA-Z0-9\u0080-\u00ff-.]*)?'+location.hostname); 
if(jsblock.blockGoogle){
	jsblock.list.push('google-analytics.com');
	jsblock.list.push('googlesyndication.com/pagead/show_ads.js');
}
/**
* reverse index of. does str.indexOf(array items)
* @return matched array index
*/
Array.prototype.rindexOf = function(str){
	for(var i=0,end=this.length;i<end;i++){
		if(str.indexOf(this[i]) > -1)return i;
	}
	return -1;
}
// listen for script loading
window.opera.addEventListener(
	'BeforeExternalScript',
	function (e) {
		var src = e.element.getAttribute('src');
		var isInternal = src.match(window.jsblock.exrx);
		// is the script an external script?
		if(src.match(/^http:\/\//)  && !isInternal){
			// Does it belong to any of the items in the block list?
			if(jsblock.list.rindexOf(src)>-1){
				if(jsblock.v.blocked)
					opera.postError('ADBLOCK script from '+location.hostname+' loads '+src);
				e.preventDefault();
			} else if(jsblock.v.suspects) {
				if(src.match('ad') || src.match('analys') || src.match('track')) {
					opera.postError('ADBLOCK, Suspect (ad|analys|track): '+location.hostname+' loads '+src);
				} 
			} else if(jsblock.v.external) {
				if(src.match(/^http:\/\//) && !isInternal) {
					opera.postError('ADBLOCK, Suspect (external script): '+location.hostname+' loads '+src);
				}
			}
		}
	},
	false
);