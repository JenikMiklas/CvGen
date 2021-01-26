//
//  HTMLString.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 26.01.2021.
//

import Foundation

struct HTMLString {
    
    static let urlResources = Bundle.main.resourceURL
    
    static var htmlString: String = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
    <meta charset="UTF-8">
    <title>Resume #NAME#</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://kit.fontawesome.com/b99e675b6e.js"></script>
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
}
