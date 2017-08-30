//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require tether
//= require bootstrap
//= require masonry/masonry.min

"use strict";

var Theme1 = function() {
  var self = this;
  this.$masonryContainer = $("#masonry-container");
  this.$nextParams = {};

  this.initMasonry();
  this.bindInfinteScroll();
  this.autoScroll();
  this.getPosts();
};

Theme1.prototype = {
  initMasonry: function() {
    this.$masonryContainer.masonry({
      itemSelector: '.box',
      columnWidth: 100,
      gutterWidth: 40,
      isFitWidth: true
    });
  },
  bindInfinteScroll: function() {
    var self = this;
    $(window).on("scroll", function(e) {
      var $cont = $(this),
          $content = $(document);

      var contentHeight = $content.height() - $cont.scrollTop();

      if (contentHeight <= $cont.height()) { self.getPosts(); }
    });
  },
  autoScroll: function() {
    var self = this;
    $(window).scrollTop($(window).scrollTop()+10);
    setTimeout(function() {
      self.autoScroll()
    }, 100);
  },
  getPosts: function() {
    var self = this;
    var params = this.$nextParams
    $.ajax({
      url: "/themes/posts",
      method: "get",
      dataType: "json",
      data: {
        next_page_params: params
      },
      success: function(payload) {
        self.addPosts(payload.posts)
        if (payload.has_next_page) {
          self.$nextParams = payload.next_page_params;
        }
      }.bind(this),
      error: function(xhr, status, err) {
      }.bind(this)
    });
  },
  addPosts: function(posts) {
    $.each(posts, function(index, post) {
      this.addPost(post);
    }.bind(this));
  },
  addPost: function(post) {
    var self = this
    var template = $(".box.template").clone();
    template.removeClass("template");
    template.css({ opacity: 0 });
    template.find(".title").text(post.title);
    template.find(".username").text(JSON.parse(post.author).name);

    if (post.image) {
      var img = $("<img src='" + post.image + "'/>");
      template.find(".img-container").append(img);
      img.one("load", function() {
        template.animate({ opacity: 1 })
        self.$masonryContainer.append(template).masonry("appended", template, false);
      });
    } else {
      template.animate({ opacity: 1 })
      this.$masonryContainer.append(template).masonry("appended", template, false);
    }
  }
};

$(document).ready(function() {
  window.theme1 = new Theme1();
});
