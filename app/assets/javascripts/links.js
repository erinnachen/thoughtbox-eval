$(document).ready(function(){
  $('#alphabetical').on("click", function(){
    var sortedLinks = sortLinksAlphabetically();
    $('.links').empty();
    addSortedLinks(sortedLinks);
  });

  $('#read-links').on("click", function(){
    showOnlyLinks("read");
  });
  $('#unread-links').on("click", function(){
    showOnlyLinks("unread");
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

function showOnlyLinks(status) {
  var allLinks = $('.links .link');
  for(var i=0; i<allLinks.length; i++) {
    if (status === "read" && allLinks.eq(i).hasClass("read")){
      allLinks.eq(i).show();
    } else if (status === "unread" && allLinks.eq(i).hasClass("unread")){
      allLinks.eq(i).show();
    } else {
      allLinks.eq(i).hide();
    }
  }
}
