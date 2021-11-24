// Markdown Loader
function loadMDFile(pagePath) {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "pages/" + pagePath, true);
    xhr.onload = function() {
        if (xhr.status == 200) {
            var formattedMarkdown = marked.parse(xhr.responseText);
            var sanitizedHtml = DOMPurify.sanitize(formattedMarkdown, { USE_PROFILES: { html: true } });
            document.getElementById("content").innerHTML = sanitizedHtml;
        } else {
            alert("Could not load the desired page. Please try again later.");
        }
    }
    xhr.send();
}