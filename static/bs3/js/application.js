// initialise plugins
$(function(){

    var autocompleteUrl = 'https://bie.ala.org.au/ws/search/auto';

    if(typeof BIE_VARS != 'undefined' && BIE_VARS.autocompleteUrl){
        autocompleteUrl = BIE_VARS.autocompleteUrl;
    }

    // autocomplete on navbar search input
    $("#biesearch").autocomplete(autocompleteUrl, {
        extraParams: {limit: 100},
        dataType: 'json',
        parse: function(data) {
            var rows = new Array();
            data = data.autoCompleteList;
            for(var i=0; i<data.length; i++) {
                rows[i] = {
                    data:data[i],
                    value: data[i].matchedNames[0],
                    result: data[i].matchedNames[0]
                };
            }
            return rows;
        },
        matchSubset: false,
        formatItem: function(row, i, n) {
            return row.matchedNames[0];
        },
        cacheLength: 10,
        minChars: 3,
        scroll: false,
        max: 10,
        selectFirst: false
    });
    ////action on hitting enter
    //$("input.general-search").keypress(function(e) {
    //    if(e.which == 13) {
    //        var searchTerm = $("input.general-search").val().trim();
    //        alert("Search term: " + searchTerm);
    //        if(searchTerm != ""){
    //            console.log("redirecting to https://bie.ala.org.au/search?q=" + searchTerm);
    //            window.location = "https://bie.ala.org.au/search?q=" + searchTerm;
    //        }
    //    }
    //});
    // Mobile/desktop toggle
    // TODO: set a cookie so user's choice is remembered across pages
    var responsiveCssFile = $("#responsiveCss").attr("href"); // remember set href
    $(".toggleResponsive").click(function(e) {
        e.preventDefault();
        $(this).find("i").toggleClass("icon-resize-small icon-resize-full");
        var currentHref = $("#responsiveCss").attr("href");
        if (currentHref) {
            $("#responsiveCss").attr("href", ""); // set to desktop (fixed)
            $(this).find("span").html("Mobile");
        } else {
            $("#responsiveCss").attr("href", responsiveCssFile); // set to mobile (responsive)
            $(this).find("span").html("Desktop");
        }
    });
});
