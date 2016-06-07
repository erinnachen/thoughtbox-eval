$(document).ready(function(){
  $('#alphabetical').on("click", function(){
    var sortedLinks = sortLinksAlphabetically();
    $('.links').empty();
    addSortedLinks(sortedLinks);
  });

  $('#read-links').on("click", function(){
    showOnlyLinks("read");
    updateListStatus("read-list");
  });

  $('#unread-links').on("click", function(){
    showOnlyLinks("unread");
    updateListStatus("unread-list");
  });

  $('#all-links').on("click", function(){
    showAllLinks();
    updateListStatus("all");
  });

  $('.links').on("click", "button.change-status", function(e){
    var button = $(this);
    var status = getStatus(button);
    var id = getId(button);
    var new_status = getNewStatus(status);
    var listFilter = getCurrentFilter();
    $.ajax({type: 'PATCH',
            url: '/api/v1/links/'+id,
            data: {link: {read: new_status}},
            success: swapReadStatus($(this).parent(), status, listFilter)
          });

  });

  $( "#link_search" ).keydown(function(e){
    if (e.keyCode === 13) {
      e.preventDefault();
      return;
    }
  });

  $( "#link_search" ).keyup(function(e) {
    $('.link').each(function(){
      var searchStr = $('#link_search').val().toLowerCase();
      var title = $(this).children().first().text().toLowerCase();
      if (searchMatch(title, searchStr)) {
        $(this).show();
      } else {
        $(this).hide();
      }
    });
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

function showAllLinks() {
  var allLinks = $('.links .link');
  for(var i=0; i<allLinks.length; i++) {
    allLinks.eq(i).show();
  }
}

function updateListStatus(status) {
  var links = $('.links');
  links.attr("class", "links");
  if (status !== "all") {
    links.addClass(status);
  }
}

function searchMatch(title, searchStr) {
  return title.indexOf(searchStr) !== -1;
}

function swapReadStatus(link, status, listFilter) {
  if (status === "read") {
    $(link).removeClass("read");
    $(link).addClass("unread");
    $(link).children("button")[0].innerHTML = "Mark as Read"
  } else {
    $(link).removeClass("unread");
    $(link).addClass("read");
    $(link).children("button")[0].innerHTML = "Mark as Unread"
  }
  if (listFilter !== "all") {
    showOnlyLinks(listFilter);
  }
}

function getStatus(button) {
  var linkStatus = $(button).parent().attr('class')
  var sind = linkStatus.indexOf(" ");
  return linkStatus.slice(sind+1);
}

function getId(button) {
  var id = $(button).parent().attr('id');
  var sid = id.indexOf("-");
  return id.slice(sid+1);
}

function getNewStatus(status) {
  if (status === "read") { return false; }
  return true;
}

function getCurrentFilter(){
  var links = $('.links')
  if ($(links).hasClass("unread-list")) { return "unread"; }
  if ($(links).hasClass("read-list"))   { return "read"; }
  return "all";
}
