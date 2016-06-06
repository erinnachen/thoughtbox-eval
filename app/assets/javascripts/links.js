$(document).ready(function(){
  $('#alphabetical').on("click", function(e){
    var sortedLinks = sortLinksAlphabetically();
    $('.links').empty();
    addSortedLinks(sortedLinks);
  });
});

function sortLinksAlphabetically() {
  var sortedLinks = $('.links .link').sort(function(linkA, linkB){
    var nameA = linkA.firstChild.nextSibling.innerText.toLowerCase();
    var nameB = linkB.firstChild.nextSibling.innerText.toLowerCase();
    if (nameA < nameB) {
      return -1;
    }
    if (nameA > nameB) {
      return 1;
    }
    return 0;
  });
  return sortedLinks;
}

function addSortedLinks(sortedLinks) {
  var linksList = $('.links')
  for(var i=0; i < sortedLinks.length; i++) {
    linksList.append(sortedLinks[i]);
  }
}
