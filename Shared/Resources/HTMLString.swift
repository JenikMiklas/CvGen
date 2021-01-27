//
//  HTMLString.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import Foundation

struct HTMLString {
    
    static var pdfData = Data()
    
    static let urlResources = Bundle.main.resourceURL
    
    static var htmlString: String = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <title>Resume #NAME#</title>
    <style>
    * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    list-style: none;
    font-family: "Montserrat", sans-serif;
    }

    body {
    background: #ffffff;
    font-size: 14px;
    line-height: 22px;
    color: #555555;
    }

    .bold {
    font-weight: 700;
      font-size: 20px;
      text-transform: uppercase;
    }

    .semi-bold {
      font-weight: 500;
      font-size: 16px;
    }

    .resume {
      width: 800px;
      height: auto;
      display: flex;
      margin: 50px auto;
    }

    .resume .resume_left {
      width: 280px;
      background: #0bb5f4;
    }

    .resume .resume_left .resume_profile {
      width: 100%;
      height: 280px;
    }

    .resume .resume_left .resume_profile img {
      width: 100%;
      height: 100%;
    }

    .resume .resume_left .resume_content {
      padding: 0 25px;
    }

    .resume .title {
      margin-bottom: 20px;
    }

    .resume .resume_left .bold {
      color: #fff;
    }

    .resume .resume_left .regular {
      color: #b1eaff;
    }

    .resume .resume_item {
      padding: 25px 0;
      border-bottom: 2px solid #b1eaff;
    }

    .resume .resume_left .resume_item:last-child,
    .resume .resume_right .resume_item:last-child {
      border-bottom: 0px;
    }

    .resume .resume_left ul li {
      display: flex;
      margin-bottom: 10px;
      align-items: center;
    }

    .resume .resume_left ul li:last-child {
      margin-bottom: 0;
    }

    .resume .resume_left ul li .icon {
      width: 35px;
      height: 35px;
      background: #fff;
      color: #0bb5f4;
      border-radius: 50%;
      margin-right: 15px;
      font-size: 16px;
      position: relative;
    }

    .resume .icon i,
    .resume .resume_right .resume_hobby ul li i {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }

    .resume .resume_left ul li .data {
      color: #b1eaff;
    }

    .resume .resume_left .resume_skills ul li {
      display: flex;
      margin-bottom: 10px;
      color: #b1eaff;
      justify-content: space-between;
      align-items: center;
    }

    .resume .resume_left .resume_skills ul li .skill_name {
      width: 25%;
    }

    .resume .resume_left .resume_skills ul li .skill_progress {
      width: 60%;
      margin: 0 5px;
      height: 5px;
      background: #009fd9;
      position: relative;
    }

    .resume .resume_left .resume_skills ul li .skill_per {
      width: 15%;
    }

    .resume .resume_left .resume_skills ul li .skill_progress span {
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      background: #fff;
    }

    .resume .resume_left .resume_social .semi-bold {
      color: #fff;
      margin-bottom: 3px;
    }

    .resume .resume_right {
      width: 520px;
      background: #fff;
      padding: 25px;
    }

    .resume .resume_right .bold {
      color: #0bb5f4;
    }

    .resume .resume_right .resume_work ul,
    .resume .resume_right .resume_education ul {
      padding-left: 40px;
      overflow: hidden;
    }

    .resume .resume_right ul li {
      position: relative;
    }

    .resume .resume_right ul li .date {
      font-size: 16px;
      font-weight: 500;
      margin-bottom: 15px;
    }

    .resume .resume_right ul li .info {
      margin-bottom: 20px;
    }

    .resume .resume_right ul li:last-child .info {
      margin-bottom: 0;
    }

    .resume .resume_right .resume_work ul li:before,
    .resume .resume_right .resume_education ul li:before {
      content: "";
      position: absolute;
      top: 5px;
      left: -25px;
      width: 6px;
      height: 6px;
      border-radius: 50%;
      border: 2px solid #0bb5f4;
    }

    .resume .resume_right .resume_work ul li:after,
    .resume .resume_right .resume_education ul li:after {
      content: "";
      position: absolute;
      top: 14px;
      left: -21px;
      width: 2px;
      height: 115px;
      background: #0bb5f4;
    }

    .resume .resume_right .resume_hobby ul {
      display: flex;
      justify-content: space-between;
    }

    .resume .resume_right .resume_hobby ul li {
      width: 80px;
      height: 80px;
      border: 2px solid #0bb5f4;
      border-radius: 50%;
      position: relative;
      color: #0bb5f4;
    }

    .resume .resume_right .resume_hobby ul li i {
      font-size: 30px;
    }

    .resume .resume_right .resume_hobby ul li:before {
      content: "";
      position: absolute;
      top: 40px;
      right: -52px;
      width: 50px;
      height: 2px;
      background: #0bb5f4;
    }

    .resume .resume_right .resume_hobby ul li:last-child:before {
      display: none;
    }
    </style>
    </head>
    <body>
    <div class="resume">
    <div class="resume_left">
     <div class="resume_profile">
       <img src="face.png" alt="profile_pic">
     </div>
     <div class="resume_content">
       <div class="resume_item resume_info">
         <div class="title">
           <p class="bold">#NAME#</p>
           <p class="regular">#CARRER#</p>
         </div>
         <ul>
           <li>
             <div class="icon">
               <i class="fas fa-map-signs"></i>
             </div>
             <div class="data">
                #ADDRESS# <br /> #STATE#
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fas fa-mobile-alt"></i>
             </div>
             <div class="data">
                #TEL#
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fas fa-envelope"></i>
             </div>
             <div class="data">
                #E-MAIL#
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fab fa-weebly"></i>
             </div>
             <div class="data">
                #WEB#
             </div>
           </li>
         </ul>
       </div>
       <div class="resume_item resume_skills">
         <div class="title">
           <p class="bold">#SKILL'S#</p>
         </div>
         <ul>
           <li>
             <div class="skill_name">
                #SKILL#
             </div>
             <div class="skill_progress">
               <span style="width: #SKILL PROGRESS#;"></span>
             </div>
             <div class="skill_per">#SKILL PROGRESS#</div>
           </li>
         </ul>
       </div>
       <div class="resume_item resume_social">
         <div class="title">
           <p class="bold">#SOCIAL#</p>
         </div>
         <ul>
           <li>
             <div class="icon">
               <i class="fab fa-facebook-square"></i>
             </div>
             <div class="data">
               <p class="semi-bold">Facebook</p>
               <p>Stephen@facebook</p>
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fab fa-twitter-square"></i>
             </div>
             <div class="data">
               <p class="semi-bold">Twitter</p>
               <p>#TWITTER#</p>
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fab fa-youtube"></i>
             </div>
             <div class="data">
               <p class="semi-bold">Youtube</p>
               <p>Stephen@youtube</p>
             </div>
           </li>
           <li>
             <div class="icon">
               <i class="fab fa-linkedin"></i>
             </div>
             <div class="data">
               <p class="semi-bold">Linkedin</p>
               <p>Stephen@linkedin</p>
             </div>
           </li>
         </ul>
       </div>
     </div>
    </div>
    <div class="resume_right">
    <div class="resume_item resume_about">
        <div class="title">
           <p class="bold">#ABOUT#</p>
         </div>
        <p>#PERSONAL#</p>
    </div>
    <div class="resume_item resume_work">
        <div class="title">
           <p class="bold">#JOBS#</p>
         </div>
        <ul>
            <li>
                <div class="date">#JOBS DATE#</div>
                <div class="info">
                     <p class="semi-bold">#COMPANY#</p>
                  <p>#JOB DESCRIPTION#</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="resume_item resume_education">
      <div class="title">
           <p class="bold">#EDU#</p>
         </div>
      <ul>
            <li>
                <div class="date">#EDU DATE#</div>
                <div class="info">
                     <p class="semi-bold">#EDU SCHOOL#</p>
                  <p>#EDU DESCRIPTION#</p>
                </div>
            </li>
        </ul>
    </div>
    <div class="resume_item resume_hobby">
      <div class="title">
           <p class="bold">#HOBBY#</p>
         </div>
       <ul>
         <li><i class="fas fa-book"></i></li>
         <li><i class="fas fa-gamepad"></i></li>
         <li><i class="fas fa-music"></i></li>
         <li><i class="fas fa-film"></i></li>
      </ul>
       <ul>
         <div><p>#BOOK#</p><p>#BOOK#</p></div>
         <div><p>#GAME#</p><p>#GAME#</p></div>
         <div><p>#MUSIC#</p><p>#MUSIC#</p></div>
         <div><p>#FILM#</p><p>#FILM#</p></div>
      </ul>
    </div>
    </div>
    </div>

    </body>
    </html>
    """
    
    static let htmls2 = """
    <html>
    <head>
        <meta charset="utf-8" />
        <title>LogBook</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
        <table style="border: 1px solid black; border-collapse: collapse;">
            <thead style="border: 1px solid black; border-collapse: collapse;">
                <tr>
                    <th style="border: 1px solid black; border-collapse: collapse;">1</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">2</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">3</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">4</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="3">5</th>
                    <th style="border: 1px solid black; border-collapse: collapse;">6</th>
                    <th style="border: 1px solid black; border-collapse: collapse;">7</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">8</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">9</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="4">10</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2">11</th>
                    <th style="border: 1px solid black; border-collapse: collapse;">12</th>
                </tr>
                <tr>
                    <th style="border: 1px solid black; border-collapse: collapse;">DATE</th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>DEPARTURE</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>ARRIVAL</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>AIRCRAFT</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>SINGLE PILOT TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" rowspan="2"><b>MULTI PILOT TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" rowspan="2"><b>TOTAL FLIGHT TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" rowspan="2"><b>PIC NAME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>LANDINGS</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>OPERATIONAL CONDITION TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="4"><b>PILOT FUNCTION TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>FSTD SESSION</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;" rowspan="2"><b>REMARKS AND ENDORSEMENTS</b></th>
                </tr>
                <tr>
                    <th style="border: 1px solid black; border-collapse: collapse;">dd/mm/yy</th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>PLACE</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>PLACE</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>TIME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>MODEL, VARIANT</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>REGISTRATION</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>SE</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>ME</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>DAY</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>NIGHT</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>NIGHT</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>IFR</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>PIC</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>CO-PILOT</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>DUAL</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>INSTRUCTOR</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>TYPE</b></th>
                    <th style="border: 1px solid black; border-collapse: collapse;"><b>TOTAL TIME</b></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">Captaion KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;">01/03/2020</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LKPR</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">17:30</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">LEMG</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">21:00</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">A320</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">OK-HEU</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">KUBA</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">1</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3:16</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="padding:0;margin:0;vertical-align:middle; border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;" colspan="5" rowspan="3"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>TOTAL THIS PAGE</b></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">19:48</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;" rowspan="3">_</td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>TOTAL FROM PREVIOS PAGES</b></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">2016:13</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                </tr>
                <tr>
                    <td style="border: 1px solid black; border-collapse: collapse;" colspan="2"><b>TOTAL TIME</b></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse; font-weight: bold;">2045:51</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">3</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">5</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">19:48</td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;">29:38</td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                    <td style="border: 1px solid black; border-collapse: collapse;"></td>
                </tr>
            </tfoot>
        </table>
    </body>
    </html>
    """
}
