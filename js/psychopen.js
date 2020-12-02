// ==ClosureCompiler==
// @compilation_level SIMPLE_OPTIMIZATIONS
// @output_file_name default.js
// @code_url https://www.lifp.de/assets/scripts/jquery/3.5.1/jquery.min.js
// @code_url https://www.lifp.de/assets/scripts/popperjs/1.16.1/popper.min.js
// @code_url https://www.lifp.de/assets/scripts/bootstrap/4.5.2/js/bootstrap.min.js
// @code_url https://d1bxh8uas1mnw7.cloudfront.net/assets/embed.js
// @code_url https://badge.dimensions.ai/badge.js
// ==/ClosureCompiler==

/* Diese JavaScript Datei dient nur für die Entwicklung.
   Für das Theme wir die default.js verwendet, welche aus dieser Datei per googles closure composer generiert wird (https://closure-compiler.appspot.com)
   Hierfür einfach den Inhalt dieser Datei in den Composer kopieren und diesen ausführen. Dadurch werden alle benötigten Bibliotheken die im Compiler Header (siehe oben) angegeben
   sind in eine einzige JavaScript Datei geladen, optimiert und minimiert. Dies spart Ladezeiten.
   Die Verwendeten Bibliotheken sind: jquery, popper.js, bootstrap, altmetric und dimension.
   Also falls Code hier geändert, hinzugefügt oder gelöscht wird muss dieser erst über den Composter compiliert und dann in der default.js überschrieben werden!
   plumX kompiliert mit Fehler! https://cdn.plu.mx/widget-popup.js Deswegen erst einmal nicht in code_url.
   */
<!-- Matomo -->
let _paq = window._paq || [];
disableTracking(_paq);
_paq.push(["setDocumentTitle", document.domain.split('.')[0] + " - " + document.title]);
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);
(function () {
    var u = "https://pwk.clubs-project.eu/";
    _paq.push(['setTrackerUrl', u + 'matomo.php']);
    _paq.push(['setSiteId', '12']);
    var d = document, g = d.createElement('script'), s = d.getElementsByTagName('script')[0];
    g.type = 'text/javascript';
    g.async = true;
    g.defer = true;
    g.src = u + 'matomo.js';
    s.parentNode.insertBefore(g, s);
})();

function pushGoal(event, type, val) {
    if (_paq)
        _paq.push(['trackEvent', document.domain, event, type, val]);
}


$(document).ready(function () {
    $('#article-full').click(function () {
        $("#article-frame-row").addClass('article-full-fixed');
        $(".article-full-frame").css('min-height', '98%');
        $("body").css('overflow', 'hidden');
        $("#article-full-close-row").show()
    });

    $('#article-full-close').click(function () {
        $("#article-frame-row").removeClass('article-full-fixed');
        $(".article-full-frame").css('min-height', '80vh');
        $("body").css('overflow', 'auto');
        $("#article-full-close-row").hide()
    });

    $(".search-box-btn").click(function () {
        $(".search-box").slideToggle('fast')
    });

    $(function () {
        $('[data-toggle="tooltip"]').tooltip()
    })
    let height = window.innerHeight - $('header').height() - $('#mainNavbar').height() - $('footer').height();
    $('.pkp_structure_content').css('min-height', height - 16);

    $(window).resize(function () {
        let height = window.innerHeight - $('header').height() - $('#mainNavbar').height() - $('footer').height();
        $('.pkp_structure_content').css('min-height', height - 16);
    });
    $('#sidebar_show_more').click(function () {
        $('span', this).toggle();
        $(".hiddenElement").toggleClass("hidden")
    });

    if (window.location.href.indexOf("register") > -1) {
        if (window.location.href.indexOf("#formErrors") > -1) {
            let orcid = window.sessionStorage.getItem("orcid_s");
            if (orcid) {
                $('#orcid').val(orcid);
                $('#connect-orcid-button').hide();
            }
        }
        window.sessionStorage.removeItem("orcid_s");
        $('#submitReg').click(function () {
            window.sessionStorage.setItem("orcid_s", $('#orcid').val());
        })
    }
    $('.copy_to_clip_btn').click(function () {
        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val($(this).next(".copy_to_clip_txt").text()).select();
        document.execCommand("copy");
        $temp.remove();
    });

    $('.copy_to_clip_li').mouseenter(function () {
        $(this).find('.copy_to_clip_btn').show();
    });

    $('.copy_to_clip_li').mouseleave(function () {
        $(this).find('.copy_to_clip_btn').hide();
    });

	let pdfFrame = $('#article-pdf-frame');
	if (pdfFrame !== null && pdfFrame !== undefined && $(pdfFrame).data('article')) {
		pushGoal('article_PDF_view', $(pdfFrame).data('article'), 1);
	}

	let htmlFrame = $('#article-html-frame');
	if (htmlFrame !== null && htmlFrame !== undefined && $(htmlFrame).data('article')) {
		pushGoal('article_HTML_view', $(htmlFrame).data('article'), 1);
	}

	let abstractElem = $('#article-abstract-view');
	if (abstractElem !== null && abstractElem !== undefined && $(abstractElem).data('article')) {
		pushGoal('article_ABSTRACT_view', $(abstractElem).data('article'), 1);
	}
});





