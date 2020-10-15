<section class="card mb-3 default-card-layout">
    <div class="card-body">
        <div class="card-title">
            <h2>{$tweetTitle|unescape:"html"}</h2>
        </div>
        <ul class="list-group list-group-flush">
            <li class="list-group-item no-padding-left-right" style="max-height: {$tweetHeight}px; overflow-y: auto;">
                <a class="twitter-timeline" rel="noreferrer" data-height="{$tweetHeight}" data-link-color="{$tweetColor}" href="{$tweetUrl}"a data-chrome="{$tweetOptions}" data-tweet-limit="3"></a>
                <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
            </li>
        </ul>
    </div>
</section>