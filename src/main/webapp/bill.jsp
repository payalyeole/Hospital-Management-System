<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MediCore | Billing</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="/css/medicore.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>

<body>

<!-- TOPBAR -->
<nav class="topbar">
    <a href="#" class="navbar-brand">
        <span class="brand-dot"></span>
        MediCore <sup style="font-size:.55rem;letter-spacing:.12em;color:var(--muted);font-family:'DM Sans',sans-serif;">HMS</sup>
    </a>
    <div class="topbar-right">
        <div class="breadcrumb-trail">
            <a href="/dashboard.jsp"><i class="bi bi-house"></i></a>
            <i class="bi bi-chevron-right" style="font-size:.6rem;"></i>
            <span>Billing</span>
        </div>
    </div>
</nav>

<div class="page-wrap">

    <!-- HEADER -->
    <div class="page-header">
        <h1>Billing Management</h1>
        <span class="count-badge">
            <span id="total">0</span> Bills
        </span>
    </div>

    <div class="two-col">

        <!-- FORM -->
        <div class="panel">
            <div class="panel-title">Create Bill</div>

            <form id="billForm">
                <input type="text" id="patientName" class="field-input" placeholder="Patient Name" required>
                <input type="number" id="amount" class="field-input" placeholder="Amount" required>
                <input type="text" id="status" class="field-input" placeholder="Status (PAID / PENDING)" required>

                <button class="btn-add">Add Bill</button>
            </form>
        </div>

        <!-- TABLE -->
        <div class="table-panel">

            <!-- SEARCH -->
            <input type="text" id="search" class="search-input" placeholder="Search...">

            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Patient</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="data"></tbody>
            </table>

            <!-- PAGINATION -->
            <div class="pagination-bar">
                <button class="page-btn" id="prev">Prev</button>
                <span id="pageInfo"></span>
                <button class="page-btn" id="next">Next</button>
            </div>

        </div>
    </div>
</div>

<script>

const API = "/api/v1/bills";

let page = 0;
let totalPages = 1;
let cache = [];

/* LOAD DATA */
function load(q=""){
    $.get(API+"?page="+page+"&size=5", function(res){

        cache = res.content || [];
        totalPages = res.totalPages || 1;

        $("#total").text(res.totalElements || cache.length);
        $("#pageInfo").text("Page "+(page+1)+" / "+totalPages);

        render(q);
    });
}

/* RENDER */
function render(q){
    let html = "";

    cache.forEach(b=>{
        if(q && !b.patientName.toLowerCase().includes(q)) return;

        html += `
        <tr>
            <td>${b.id}</td>
            <td>${b.patientName}</td>
            <td>₹ ${b.amount}</td>
            <td>${b.status}</td>
            <td>
                <button class="btn-del" onclick="del(${b.id})">X</button>
            </td>
        </tr>`;
    });
    $("#data").html(html);
}

/* ADD */
$("#billForm").submit(function(e){
    e.preventDefault();

    let obj = {
        patientName: $("#patientName").val(),
        amount: $("#amount").val(),
        status: $("#status").val()
    };

    $.ajax({
        url: API,
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(obj),
        success: function(){
            $("#billForm")[0].reset();
            page = 0;
            load();
        }
    });
});

/* DELETE */
function del(id){
    if(confirm("Delete bill?")){
        $.ajax({
            url: API+"/"+id,
            type: "DELETE",
            success: load
        });
    }
}

/* SEARCH */
$("#search").on("input", function(){
    render(this.value.toLowerCase());
});

/* PAGINATION */
$("#prev").click(()=>{ if(page>0){page--;load();}});
$("#next").click(()=>{ if(page<totalPages-1){page++;load();}});

/* INIT */
$(function(){ load(); });
</script>
</body>
</html>