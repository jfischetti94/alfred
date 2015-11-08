$(document).ready(function() {
	editableGrid = new EditableGrid("DemoGridAttach",{
		pageSize: $("#pagesize").val()
	});

	// we build and load the metadata in Javascript
	editableGrid.load({ metadata: [
		{ name: "Padron", datatype: "string" },
		{ name: "Nombre", datatype: "string" },
		{ name: "Email", datatype: "string" },
		{ name: "Turno", datatype: "string" },
    { name: "Acciones", datatype: "html", editable: false }
	]});

  editableGrid.enableStore = false;
	// then we attach to the HTML table and render it
	editableGrid.attachToHTMLTable('studentsGrid');

	editableGrid.renderGrid();

	// update paginator whenever the table is rendered (after a sort, filter, page change, etc.)
	editableGrid.tableRendered = function() { 
		this.updatePaginator();
		countRows('#studentsGrid');
	};


	editableGrid.setPageIndex(0);
	

	countRows('#studentsGrid');
	
  // filter when something is typed into filter
  _$('filter').onkeyup = function() {	editableGrid.filter(_$('filter').value); };

 	$("#pagesize").on('change', function () {
 	        var pagesize = $(this).val();
       		editableGrid.setPageSize(pagesize); 
      		editableGrid.renderGrid();
      		countRows('#studentsGrid');
 	 });

});



// function to render the paginator control
EditableGrid.prototype.updatePaginator = function()
{
	var paginator = $("#paginator").empty();
	var nbPages = this.getPageCount();

	// get interval
	var interval = this.getSlidingPageInterval(20);
	if (interval == null) return;
	
	// get pages in interval (with links except for the current page)
	var pages = this.getPagesInInterval(interval, function(pageIndex, isCurrent) {
		if (isCurrent) return "" + (pageIndex + 1);
		return $("<a>").css("cursor", "pointer").html(pageIndex + 1).click(function(event) { editableGrid.setPageIndex(parseInt($(this).html()) - 1); });
	});
		
	// "first" link
	var link = $("<a>").html("<i class='glyphicon glyphicon-fast-backward'></i>");
	if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.firstPage(); });
	paginator.append(link);

	// "prev" link
	link = $("<a>").html("<i class='glyphicon glyphicon-step-backward'></i>");
	if (!this.canGoBack()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.prevPage(); });
	paginator.append(link);

	// pages
	for (p = 0; p < pages.length; p++) paginator.append(pages[p]).append(" | ");
	
	// "next" link
	link = $("<a>").html("<i class='glyphicon glyphicon-step-forward'></i>");
	if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.nextPage(); });
	paginator.append(link);

	// "last" link
	link = $("<a>").html("<i class='glyphicon glyphicon-fast-forward'></i>");
	if (!this.canGoForward()) link.css({ opacity : 0.4, filter: "alpha(opacity=40)" });
	else link.css("cursor", "pointer").click(function(event) { editableGrid.lastPage(); });
	paginator.append(link);
};