/**
 * Tracking des evenements avec Google Analytics
 */
$(document).ready(function() {
	
	// ==========================================
	
	/**
	 * Partage de contenu
	 */
	
	// Like/Unlike Facebook
	if(typeof(FB) !== "undefined") {
		FB.Event.subscribe('edge.create', function(response) {
			mfTrackEvent('Facebook', 'Like', response);
		});
		
		FB.Event.subscribe('edge.remove', function(response) {
			mfTrackEvent('Facebook', 'Unlike', response);
		});
	}
	
	// MySpace 
	$('.share-myspace a').click(function() {
		mfTrackEvent('MySpace', 'Share', document.location.href);
	});
	
	// ==========================================
	
	/**
	 * Commentaires
	 */
	$('form[name="CommentAdd"]').submit(function() {
		mfTrackEvent('Comment', 'Add', document.location.href);
	});
	
	// ==========================================
	
	/**
	 * Liens Amazon
	 */
	// Liens "Télécharger légalement"
	$('#mf-chronique a.mf-amazon-small, #mf-chronique a.mf-amazon-big').click(function() {
		mfTrackEvent('Amazon', 'DownloadFromReview', $('h1.mf-chronique-titre').text());
	});
	
	// Liens sponsorisés moteur de recherche
	$('#mf-result-sponsored a').click(function() {
		mfTrackEvent('Amazon', 'SponsoredSearchResult', $('h1.mf-chronique-titre').text());
	});
	
	// ==========================================
	
	/**
	 * Liens France Billet
	 */
	$('.concert-fb a').click(function() {
		var concert = $(this).parents('.concert-fb').find('.concert-fb-title').text();
		mfTrackEvent('Concerts', 'FranceBilletClick', concert);
	});
	
});

/**
 * Fonction wrapper pour le tracking
 * @param string category
 * @param string action
 * @param string label
 * @param int value
 */
function mfTrackEvent(category, action, label, value) {
	var eventArray = ['_trackEvent', category, action];

	if(label != undefined)
		eventArray.push(label);
	if(value != undefined)
		eventArray.push(value);
	
	_gaq.push(eventArray);
}

/**
 * Callback pour le bouton Google +1
 * @param Object status Objet avec les propriétés "href" et "state" ('on' ou 'off')
 */
function googlePlusOneCallback(status) {
	if(status.state == 'on')
		mfTrackEvent('Google', 'PlusOne', status.href);
	else if(status.state == 'off')
		mfTrackEvent('Google', 'PlusOneOff', status.href);
}