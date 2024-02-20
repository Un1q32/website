window.onload = function() {
    if (window.location.protocol === 'https:') {
        var links = document.getElementsByTagName('a');
        for (var i = 0; i < links.length; i++) {
            if (links[i].href.startsWith('http://')) {
                links[i].href = links[i].href.replace('http://', 'https://');
            }
        }
    }
}
