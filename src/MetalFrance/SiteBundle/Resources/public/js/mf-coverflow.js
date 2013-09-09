/**
 * Coverflow
 */
var coverflowData = [];
$(document).ready(function() {

	$('#coverflow-items .mf-coverflow-item').each(function() {
		var aTitle = $(this).find('.mf-review').text().split(' - ');
		var artist = aTitle[0];
		var album = aTitle[1];
		var obj = {
			'album': album,
			'artist': artist,
			'imageUrl': $(this).find('img.mf-coverflow-image').attr('src'),
			'linkId': $(this).find('.mf-review a.mf-review-link').attr('id')
		};
		coverflowData.push(obj);
	});

	if(coverflowData.length > 0) {

	    function checkKey(e)
	    {
	        switch(e.keyCode) {
	            case 37:
	                $("#coverflow_left").trigger('click');
	                break;
	            case 39:
	                $("#coverflow_right").trigger('click');
	                break;
	            default:
	        }
	    }

		$(coverflowData).each(function(index, obj) {
	        $('#coverflow').append('<img src="' + obj.imageUrl + '" linkId="' + obj.linkId + '" width="140" height="140" alt="" />');
	    });

	    $("#coverflow").waterwheelCarousel("horizontal", {
	        startingWaveSeparation: 0,
	        startingItemSeparation: 90,
	        clickedCenter: function(clickedItem) {
	    		var linkId = $(clickedItem).attr('linkId');
	    		var el = $('#'+linkId);
	    		document.location = $(el).attr('href');
	    	}

	    });

	    $('#coverflow_container div.mf-album-name').html(coverflowData[0].artist + '<span>' + coverflowData[0].album + '</span>');

	    $("#coverflow").change(function(ev, position) {
	        var obj = coverflowData[position];
	        $('#coverflow_container div.mf-album-name').html(obj.artist + '<span>' + obj.album + '</span>');
	    });

	    if ($.browser.mozilla) {
	        $(document).keypress(checkKey);
	    } else {
	        $(document).keydown(checkKey);
	    }
	}
});