import $ from "jquery";

$(() => {
  // compound expansion
  $(".pf-list-compound-expansion .list-view-pf-expand").on("click", function () {
    let $this = $(this);
    let $heading = $(this).parents(".list-group-item");
    let $subPanels = $heading.find(".list-group-item-container");
    let index = $heading.find(".list-view-pf-expand").index(this);

    //Remove all active status
    $heading.find(".list-view-pf-expand.active").find(".fa-angle-right").removeClass("fa-angle-down")
      .end().removeClass("active")
      .end().removeClass("list-view-pf-expand-active");
    // Add active to the clicked item
    $(this).addClass("active")
      .parents(".list-group-item").addClass("list-view-pf-expand-active")
      .end().find(".fa-angle-right").addClass("fa-angle-down");
    // check if it needs to hide
    if($subPanels.eq(index).hasClass("hidden")){
      $heading.find(".list-group-item-container:visible").addClass("hidden");
      $subPanels.eq(index).removeClass("hidden");
    } else {
      $subPanels.eq(index).addClass("hidden");
      $heading.find(".list-view-pf-expand.active").find(".fa-angle-right").removeClass("fa-angle-down")
        .end().removeClass("active")
        .end().removeClass("list-view-pf-expand-active");
    }
  });

  // click close button to close the panel
  $(".pf-list-compound-expansion .list-group-item-container .close").on("click", function (){
    let $this = $(this);
    let $panel = $this.parent();

    // close the container and remove the active status
    $panel.addClass("hidden")
      .parent().removeClass("list-view-pf-expand-active")
      .find(".list-view-pf-expand.active").removeClass("active")
      .find(".fa-angle-right").removeClass("fa-angle-down")
  });
})

