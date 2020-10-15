{**
 * plugins/generic/orcidProfile/orcidProfile.tpl
 *
 * Copyright (c) 2015-2018 University of Pittsburgh
 * Copyright (c) 2014-2018 Simon Fraser University
 * Copyright (c) 2003-2018 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * ORCID Profile authorization form
 *
 *}

{capture name=orcidButton assign=orcidButton}
    <button id="connect-orcid-button" class="cmp_button pkp_button" onclick="return openORCID();" style="margin-top: 0; margin-bottom: 0">
        {$orcidIcon}
        {if $orcid && !$orcidAuthenticated}
            {translate key='plugins.generic.orcidProfile.authorise'}
        {else}
            {translate key='plugins.generic.orcidProfile.connect'}
        {/if}
    </button>
{/capture}

{capture name=orcidButtonBootstrap assign=orcidButtonBootstrap}
    <div class="card mb-3">
        <div class="card-header font-weight-bold bg-white">
            <label for="orcid">{translate key='plugins.generic.orcidProfile.fieldset'}</label>&nbsp;(
            <small style="cursor: pointer;">
                <a href="{url router="page" page="orcidapi" op="about"}" target="_blank">{translate key='plugins.generic.orcidProfile.about.title'}</a>
            </small>
            )
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-auto" id="connect-orcid-button" style="margin-top: 0; margin-bottom: 0">
                    <button class="btn btn-sm btn-outline-dark" onclick="return openORCID();">
                        {$orcidIcon}
                        {if $orcid && !$orcidAuthenticated}
                            {translate key='plugins.generic.orcidProfile.authorise'}
                        {else}
                            {translate key='plugins.generic.orcidProfile.connect'}
                        {/if}
                    </button>
                </div>
                <div class="col">
                    <input type="text" value="{$orcid}" id="orcid" name="orcid" maxlength="37" class="form-control-plaintext text-success" readonly>
                </div>
            </div>
        </div>
    </div>
{/capture}


{capture name=orcidLink assign=orcidLink}
    {if $orcidAuthenticated}
        <a href="{$orcid}" target="_blank">{$orcidIcon}{$orcid}</a>
    {else}
        <div style="color: red">{translate key="plugins.generic.orcidProfile.author.unauthenticated"}</div>
        <div><span>ORCID:</span>&nbsp;<a href="{$orcid}" target="_blank">{$orcid}</a></div>
        <div>{$orcidButton}</div>
    {/if}
{/capture}

<script type="text/javascript">
    function openORCID() {ldelim}
        // First sign out from ORCID to make sure no other user is logged in
        // with ORCID
        $.ajax({ldelim}
            url: '{$orcidUrl|escape}userStatus.json?logUserOut=true',
            dataType: 'jsonp',
            success: function (result, status, xhr) {ldelim}
                console.log("ORCID Logged In: " + result.loggedIn);
                {rdelim},
            error: function (xhr, status, error) {ldelim}
                console.log(status + ", error: " + error);
                {rdelim}
            {rdelim});
        var oauthWindow = window.open("{$orcidOAuthUrl}", "_blank", "toolbar=no, scrollbars=yes, width=500, height=700, top=500, left=500");
        oauthWindow.opener = self;
        console.log($('#orcid').val());
        document.cookie = "username=dsgdfg";
        return false;
        {rdelim}
    {if $targetOp eq 'profile'}
    $(document).ready(function () {ldelim}
        var orcidInput = $('input[name=orcid]');
        orcidInput.attr('type', 'hidden');
        var orcidLinkOrButton = $(
                {if $orcid}
                {$orcidLink|json_encode}
                {else}
                {$orcidButton|json_encode}
                {/if});
        orcidLinkOrButton.insertAfter(orcidInput);
        {rdelim});
    {/if}
</script>

{if $targetOp eq 'register'}
    {*{fbvElement type="hidden" name="orcid" id="orcid" value=$orcid maxlength="37"}*}
    {$orcidButtonBootstrap}
{/if}
