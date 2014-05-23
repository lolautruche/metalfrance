$(document).ready(function() {
    
	/**
	 * Actus
	 */
	$('#actu-carousel').jcarousel({
	    vertical: false,
	    auto: 8,
	    scroll: 1,
	    wrap: "circular",
	    buttonNextHTML: null,
	    buttonPrevHTML: null,
	    initCallback: function(carousel) {
	        jQuery('.mf-page li a').bind('click', function() {
	            carousel.scroll(jQuery.jcarousel.intval(jQuery(this).text()));
	            return false;
	        });
	    }
	});
	
	// ==========================================
	
	/**
	 * Carousel vertical
	 */
    $("#featured > ul").tabs({fx:{opacity: "toggle"}}).tabs("rotate", 5000, true);
    $('#featured .ui-tabs-panel > .content').hide();

	// ==========================================
    
    /**
     * Polaroid
     */
    $('.mf-polaroid').each(function() {
        var num = Math.floor(Math.random() * 11) - 6;
        $(this).transform({ rotate: num + 'deg' });
        $(this).css('opacity', 0.5);
    });
    
    $('.mf-polaroid').mouseenter(function() {
        $(this).fadeTo('fast', 1.0);
    }).mouseleave(function() {
        $(this).fadeTo('fast', 0.5);
    });
    
    $('.mf-gallery-home .mf-polaroid, .mf-gallery-list .mf-polaroid').click(function() {
    	document.location = $(this).find('.mf-polaroid-link').attr('href');
    });
    
    $('.mf-polaroid > .content').hide();
    
    // ==========================================
    
    /**
     * PrettyPhoto Lightbow
     */
    $("a[rel^='prettyPhoto']").prettyPhoto({
    	show_title: false,
    	hideflash: true,
    	social_tools: false,
    	deeplinking: false,
    	allow_resize: false,
    	changepicturecallback: function() {
    		if($('#mf-gallery').length > 0) {
	    		var galleryTitle = $('#mf-gallery h1.mf-title').text();
	    		mfTrackEvent('Photos', 'Display', galleryTitle);
    		}
    	}
    });
    
    // ==========================================
    
    /**
     * Moteur de recherche
     */
    $('#searchbuttonfield').click(function() {
        if ( $('#searchtext').val() === $('#searchtext').attr('title') ) 
            return;
        
    	$('#searchbutton').click();
    });
    
    $('input.searchbox').focusin(function() {
    	if($(this).val() === $(this).attr('title')) {
    		$(this).val('');
    		$(this).removeClass('searchempty');
    	}
    });
    
    $('input.searchbox').focusout(function() {
    	if($(this).val() === '') {
    		$(this).val($(this).attr('title'));
    		$(this).addClass('searchempty');
    	}
    });
    
    $('#searchlocalize').change(function() {
    	if($(this).is(':checked')) {
    		$(this).parent().find('input.searchbox').attr('disabled', 'disabled');
    	} else {
    		$(this).parent().find('input.searchbox').removeAttr('disabled');
    	}
    });
    
    // ==========================================
    
    /*
     * Social widgets
     */
    // Google +1
    if(typeof(gapi) !== "undefined" && $('#mf-google-plusone').length > 0) {
    	gapi.plusone.go("mf-google-plusone");
    }
});