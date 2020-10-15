// ==ClosureCompiler==
// @compilation_level SIMPLE_OPTIMIZATIONS
// @output_file_name default.js
// ==/ClosureCompiler==
let optOutTTL = (new Date("04/01/2020").getTime() - new Date().getTime()) / (1000 * 3600 * 24);
let zpid_consent = getCookie('zpid_consent');
let customVarID = getCookie('customVarID');
let customVarName = document.domain;
let banner_bottom_id = 'bottom_sm';
let banner_top_id = 'top_sm';
let studyTracker = null;

window.piwikAsyncInit = function () {
    try {
        if (zpid_consent == null) {
            let count = (getCookie('zpid_req') != null) ? parseInt(getCookie('zpid_req')) : 0;
            studyTracker = Piwik.getTracker("https://pwk.clubs-project.eu/matomo.php", 13);
            let cvnCookie = getCookie('customVarName');
            if (cvnCookie == null) {
                setCookie('customVarName', customVarName);
                count = 0;
            } else if (customVarName !== cvnCookie) {
                studyTracker.appendToTrackingUrl('new_visit=1');
                studyTracker.deleteCookies();
                count = 0;
                setCookie('customVarName', customVarName);
            }
            if (customVarID == null) {
                customVarID = (Math.random() <= 0.5) ? banner_bottom_id : banner_top_id;
                setCookie('customVarID', customVarID);
            }
            if (count === 0) {
                studyTracker.trackEvent(customVarName, customVarID, 'new_visit', 1);
            }
            studyTracker.trackEvent(customVarName, customVarID, 'amount_banner_displayed', ++count);
            setCookie('zpid_req', count);
            buildBannerAndListener();
        } else {
            pushMatomoSettings(zpid_consent === 'true');
        }
    } catch (err) {
        console.log(err);
    }
};

function disableTracking(_paq) {
    if (zpid_consent === 'false') {
        _paq.push(['requireConsent']);
        _paq.push(['disableCookies']);
    }
}


function buildBannerAndListener() {
    let optOut = document.createElement("div");
    optOut.id = "optout-form";
    optOut.style.position = 'fixed';
    optOut.style.minWidth = '100%';
    if (customVarID === banner_bottom_id)
        optOut.style.bottom = '0';
    else if (customVarID === banner_top_id) {
        optOut.style.top = "0";
        optOut.style.zIndex = '10000';
    }
    optOut.style.margin = '0';
    optOut.style.padding = '20px';
    optOut.style.color = 'white';
    optOut.style.textAlign = 'center';
    optOut.style.backgroundColor = 'rgba(0,0,0,0.8)';
    let paragraph = document.createElement("p");
    paragraph.innerHTML = "This site uses Matomo to analyze traffic and help us to improve your user experience.";
    paragraph.innerHTML += "<br />";
    paragraph.innerHTML += "It is processing your IP address and stores cookies on your browser. Those data are only processed by us and our web hosting platform.";
    paragraph.innerHTML += "<br />";
    let link = document.createElement("a");
    link.href = 'https://leibniz-psychology.org/en/rechtliches/legal-notice-data-privacy/';
    link.target = '_blank';
    link.rel = 'noopener';
    link.innerText = 'Learn more about our Privacy Policy';
    link.style.color = '#2ea8ce';
    link.style.fontWeight = 'bold';
    link.style.textDecoration = 'none';
    paragraph.append(link);
    optOut.append(paragraph);
    paragraph = document.createElement("p");
    let btn_revoke = document.createElement("button");
    btn_revoke.innerHTML = 'Decline Tracking';
    paragraph.append(btn_revoke);
    let btn_accept = document.createElement("button");
    btn_accept.innerHTML = 'Accept Cookies';
    setButtonMargin(btn_revoke, btn_accept, window.innerWidth);
    styleButton(btn_accept, 'green');
    styleButton(btn_revoke, 'gray');
    paragraph.append(btn_accept);
    optOut.append(paragraph);
    document.body.append(optOut);
    btn_revoke.addEventListener("click", function () {
        optOut.style.display = 'none';
        studyTracker.trackEvent(customVarName, customVarID, 'consent_given', 0);
        studyTracker.trackContentInteractionNode(this, 'revokeTracking');
        pushMatomoSettings(false);
        setCookie('zpid_consent', 'false');
    });
    btn_accept.addEventListener("click", function () {
        optOut.style.display = 'none';
        studyTracker.trackEvent(customVarName, customVarID, 'consent_given', 1);
        studyTracker.trackContentInteractionNode(this, 'acceptTracking');
        pushMatomoSettings(true);
        setCookie('zpid_consent', 'true');
    });

    window.onresize = function (event) {
        setButtonMargin(btn_revoke, btn_accept, window.innerWidth)
    }
}

/**
 * Button Style Function
 *
 * @param btn button
 * @param bgColor Background Color
 */
function styleButton(btn, bgColor) {
    btn.style.backgroundColor = bgColor;
    btn.style.border = 'none';
    btn.style.padding = '10px 20px';
    btn.style.borderRadius = '5px';
    btn.style.color = 'white'
}

/**
 * Sets the Margin for the accept and decline button depending on the windows size
 *
 * @param btn_off decline button
 * @param btn_on accept button
 * @param w window.innerWidth
 */
function setButtonMargin(btn_off, btn_on, w) {
    if (w > 480) {
        btn_off.style.marginRight = '15vw';
        btn_on.style.marginLeft = '15vw'
    } else if (w > 400) {
        btn_off.style.marginRight = '10px';
        btn_on.style.marginLeft = '10px'
    } else if (w > 335) {
        btn_off.style.marginRight = '1px';
        btn_on.style.marginLeft = '1px'
    } else {
        btn_off.style.marginBottom = '5px'
    }
}

/**
 * Pushes the Opt Settings to matomos _paq array.
 * @param enabled true(consent given), false (consent declined)
 */
function pushMatomoSettings(enabled) {
    _paq.push([enabled ? 'forgetUserOptOut' : 'optUserOut']);
    _paq.push([enabled ? 'setConsentGiven' : 'forgetConsentGiven']);
}

/**
 * Saves the zpid consent given cookie.
 * Functional required true/false option with expire date.
 * This cookie is used to save the users selection for a specific time
 *
 * @param name
 * @param cvalue true(consent given), false (consent declined)
 */
function setCookie(name, cvalue) {
    if (optOutTTL > 0) {
        let d = new Date();
        d.setTime(d.getTime() + (optOutTTL * 24 * 60 * 60 * 1000));
        let expires = "expires=" + d.toUTCString();
        document.cookie = name + "=" + cvalue + ";" + expires + ";path=/"
    } else
        document.cookie = name + "=" + cvalue + ";path=/"
}

/**
 * Loads the zpid cookie and returns its value
 *
 * @returns {string|null}
 */
function getCookie(name) {
    name = name + "=";
    let decodedCookie = decodeURIComponent(document.cookie);
    let ca = decodedCookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1)
        }
        if (c.indexOf(name) === 0) {
            return c.substring(name.length, c.length)
        }
    }
    return null
}


