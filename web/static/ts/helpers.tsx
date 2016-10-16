// helpers
// read meta tag content
export function getContent (name: string) {
  return JSON.parse(
    document.querySelector("meta[name='" + name + "']").getAttribute("content")
  );
}


export function getCRSF () {
    return document.querySelector("meta[name='csrf-token']").getAttribute("content");
}