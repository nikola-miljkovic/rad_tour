// helpers
// read meta tag content
export function getContent<T>(name: string): T {
    let doc = document.querySelector("meta[name='" + name + "']");
    if (doc == undefined) {
        return null;
    } else {
        return JSON.parse(
            doc.getAttribute("content")
        ) as T;
    }
}

export function getCRSF () {
    return document.querySelector("meta[name='csrf-token']").getAttribute("content");
}

