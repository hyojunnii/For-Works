<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<style>
    div,input{margin-bottom: 1%;}
    .nbtn{
    padding: 0;
    border: none;
    background: none;
    }
    
    
</style>
<div id="container" style="margin: 3% 5%;">
        <form action="" style="width: 80%; margin-left: 10%;">
            
            <div style="justify-content: center; align-items: center;">
                <div class="md-3"> 
                    <label for="title" class="form-label">등록자</label>
                    <input type="text" class="form-control" id="title" name="title">
                    <br>
                </div>
                
                <div class="md-3"> 
                    <label for="title" class="form-label">등록부서</label>
                    <input type="text" class="form-control" id="title" name="title" >
                </div>

                <div class="md-3"> 
                    <label for="title" class="form-label">자사명</label>
                    <input type="text" class="form-control" id="title" name="title" >
                </div>

                <div class="md-3"> 
                    <label for="title" class="form-label">모델명</label>
                    <input type="text" class="form-control" id="title" name="title" >
                </div>

                <div class="md-3"> 
                    <label for="title" class="form-label">취득일자</label>
                    <input type="text" class="form-control" id="title" name="title" >
                </div>
                
                
                <label for="">공유자원 여부</label>
                <input class="form-check-input" type="checkbox" name="exampleRadios" id="exampleRadios1" value="option1" >
                
                <div class="md-3"> 
                    <label for="title" class="form-label">비고</label>
                    <!-- <input type="text" class="form-control" id="title" name="title" s> -->
                    <textarea class="form-control" name="" id="" cols="30" rows="10"></textarea>
                </div>


                <div class="md-3">
                    <input type="file" class="form-control" >
                </div>
                
            </div>
        </form>
        
</div>