//
//  PDFDataCreator.swift
//  CvGen (iOS)
//
//  Created by Jan Miklas on 20.02.2021.
//

import PDFKit

class PDFDataCreator: NSObject {
    
    let person: Person
    
    init(person: Person) {
        self.person = person
    }
    
    func createPDF() -> Data {
        let pdfMetaData = [kCGPDFContextCreator: "CvGen",
                           kCGPDFContextAuthor: person.name,
                           kCGPDFContextTitle: person.name]
        
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 72 * 8.3
        let pageHeight = 72 * 11.7
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { context in
            
            context.beginPage()
            
            addStrip(context: context.cgContext, pageWidth: pageWidth, pageHeight: pageHeight)
            let imageBottom = addImage(pageRect: pageRect, imageTop: 0)
            let contactBottom = addContact(page: CGRect(x: 0, y: 0, width: 200, height: imageBottom))
            let skillsBottom = addDivider(context: context.cgContext, width: 200, posY: contactBottom)
            let dividerBottom = addSkills(page: CGRect(x: 0, y: 0, width: 200, height: skillsBottom))
            let topSocials = addDivider(context: context.cgContext, width: 200, posY: dividerBottom)
            addSocials(page: CGRect(x: 0, y: 0, width: 200, height: topSocials))
            addBodyText(pageRect: CGRect(x: 200, y: 0, width: pageWidth-200, height: 0), context: context.cgContext)
            //addNameTitle(pageRect: CGRect(x: 0, y: 0, width: 200, height: imageBottom))
            /*let titleBottom = addTitle(pageRect: pageRect)
            //addBodyText(pageRect: pageRect, textTop: titleBottom + 36.0)
            addBodyText(pageRect: pageRect, textTop: imageBottom + 18.0)*/
            
            
        }
        
        return data
    }
    
    private func addContact(page: CGRect) -> CGFloat {
        
        let icons = ["home", "tel", "mail", "www"]
        let text = ["\(person.address?.street ?? "")\n\(person.address?.zip ?? ""), \(person.address?.state ?? "")", "\(person.phone ?? "")", "\(person.email ?? "")", "\(person.web ?? "")"]
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue", size: 12) as Any, .foregroundColor: UIColor.white]
        
        var positionY = page.height - 10
    
        let nameAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 18) as Any, .foregroundColor: UIColor.white]

        let nameString = NSMutableAttributedString(string: "\(person.name ?? "")\n", attributes: nameAttributes)
        let jobString = NSAttributedString(string: person.job ?? "", attributes: attributes)

        nameString.append(jobString)
        let nameRect = CGRect(x: (page.width - nameString.size().width)/2, y: positionY, width: nameString.size().width, height: nameString.size().height)
        
        nameString.draw(in: nameRect)
        
        positionY += nameString.size().height + 10
        print(nameString.size().height)
        
        for item in 0..<icons.count {
            let icon = NSTextAttachment()
            icon.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
            
            icon.image = UIImage(named: icons[item])
            let iconString = NSAttributedString(attachment: icon)
            
            let attributedString = NSAttributedString(string: text[item], attributes: attributes)
            
            let maxHeight = max(iconString.size().height, attributedString.size().height)
            
            var iconRect: CGRect
            var stringRect: CGRect
            if maxHeight <= iconString.size().height {
                iconRect = CGRect(x: 10, y: positionY, width: iconString.size().width, height: iconString.size().height)
                stringRect = CGRect(x: iconRect.maxX + 10, y: positionY + (maxHeight-attributedString.size().height)/2, width: attributedString.size().width, height: attributedString.size().height)
            } else {
                iconRect = CGRect(x: 10, y: positionY + (maxHeight-iconString.size().height)/2, width: iconString.size().width, height: iconString.size().height)
                stringRect = CGRect(x: iconRect.maxX + 10, y: positionY, width: attributedString.size().width, height: attributedString.size().height)
            }
            
            iconString.draw(in: iconRect)
            attributedString.draw(in: stringRect)
            
            positionY += maxHeight + 10
        }
        
        return positionY - 10
    }
    
    private func addSkills(page: CGRect) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 18) as Any, .foregroundColor: UIColor.white]

        let string = NSAttributedString(string: "Dovednosti", attributes: attributes)
        
        var positionY = page.height + 10
        
        let rect = CGRect(x: 20, y: positionY, width: string.size().width, height: string.size().height)
        
        string.draw(in: rect)
        
        positionY += string.size().height + 10
        
        for skill in person.skillArray {
            
            let skillAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 14) as Any, .foregroundColor: UIColor.white]
            
            let attributedString = NSAttributedString(string: skill.name ?? "", attributes: skillAttributes)
            
            var stringRect: CGRect
            
            stringRect = CGRect(x: 20, y: positionY, width: attributedString.size().width, height: attributedString.size().height)
            
            attributedString.draw(in: stringRect)
            
            positionY += attributedString.size().height + 10
        }
        
        return positionY - 5
    }
    
    private func addSocials(page: CGRect) {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 18) as Any, .foregroundColor: UIColor.white]
        
        let string = NSAttributedString(string: "Sociální Sítě", attributes: attributes)
        
        var positionY = page.height + 10
        
        let rect = CGRect(x: 20, y: positionY, width: string.size().width, height: string.size().height)
        
        string.draw(in: rect)
        
        positionY += string.size().height + 10
        
        for social in person.socialArray {
            let icon = NSTextAttachment()
            icon.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
            
            icon.image = UIImage(named: social.name ?? "")
            let iconString = NSAttributedString(attachment: icon)
            
            let skillAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 12) as Any, .foregroundColor: UIColor.white]
            let linkAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue", size: 8) as Any, .foregroundColor: UIColor.white]
            let attributedString = NSMutableAttributedString(string: "\(social.name ?? "")\n", attributes: skillAttributes)
            
            let linkString = NSAttributedString(string: social.link ?? "", attributes: linkAttributes)
            
            attributedString.append(linkString)
            
            let maxHeight = max(iconString.size().height, attributedString.size().height)
            
            var iconRect: CGRect
            var stringRect: CGRect
            
            if maxHeight <= iconString.size().height {
                iconRect = CGRect(x: 10, y: positionY, width: iconString.size().width, height: iconString.size().height)
                stringRect = CGRect(x: iconRect.maxX + 10, y: positionY + (maxHeight-attributedString.size().height)/2, width: attributedString.size().width, height: attributedString.size().height)
            } else {
                iconRect = CGRect(x: 10, y: positionY + (maxHeight-iconString.size().height)/2, width: iconString.size().width, height: iconString.size().height)
                stringRect = CGRect(x: iconRect.maxX + 10, y: positionY, width: attributedString.size().width, height: attributedString.size().height)
            }
            
            iconString.draw(in: iconRect)
            attributedString.draw(in: stringRect)
            
            positionY += maxHeight + 10
        }
    }
    
    private func addDivider(context: CGContext, width: CGFloat, posY: CGFloat) -> CGFloat {
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: width*0.1, y: posY + 15))
        context.addLine(to: CGPoint(x: width - width*0.1, y: posY + 15))
        context.setStrokeColor(CGColor(gray: 1, alpha: 1))
        context.strokePath()
        return posY + 15
    }
    
    private func addStrip(context: CGContext,pageWidth: Double, pageHeight: Double) {
        context.move(to: CGPoint(x: 0, y: 0))
        context.addRect(CGRect(x: 0, y: 0, width: 200, height: pageHeight))
        context.setFillColor(CGColor(red: 11/255, green: 181/255, blue: 244/255, alpha: 1))
        context.fillPath()
    }
    
    private func addBodyText(pageRect: CGRect, context: CGContext) {
        let sectionHeaderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue-Bold", size: 17) as Any, .foregroundColor: UIColor(red: 11/255, green: 181/255, blue: 244/255, alpha: 1)]
        
        let sectionTextStyle = NSMutableParagraphStyle()
        sectionTextStyle.alignment = .natural
        sectionTextStyle.lineBreakMode = .byWordWrapping
        
        var sectionTextAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "HelveticaNeue", size: 11) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
        
        var headerString = NSAttributedString(string: "O MNĚ", attributes: sectionHeaderAttributes)
        var textString = NSAttributedString(string: person.about ?? "", attributes: sectionTextAttributes)
        
        var positionY: CGFloat = 30.0
        
        var headerRect = CGRect(x: pageRect.minX+20, y: positionY, width: headerString.size().width, height: headerString.size().height)
        var textRect = CGRect(x: headerRect.minX, y: headerRect.minY+30, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
        
        headerString.draw(in: headerRect)
        textString.draw(in: textRect)
        
        positionY +=  textRect.minY
        
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: textRect.minX, y: positionY))
        context.addLine(to: CGPoint(x: textRect.maxX-20, y: positionY))
        context.setStrokeColor(CGColor(red: 11/255, green: 181/255, blue: 244/255, alpha: 1))
        context.strokePath()
        
        positionY += 20
        
        headerString = NSAttributedString(string: "PRACOVNÍ ZKUŠENOSTI", attributes: sectionHeaderAttributes)
        headerRect = CGRect(x: pageRect.minX+20, y: positionY, width: headerString.size().width, height: headerString.size().height)
        headerString.draw(in: headerRect)
        positionY += 30
        for job in person.jobsArray {
            let calendar = Calendar.current
            let compFrom = calendar.dateComponents([.year, .month], from: job.periodFrom ?? Date())
            let compTo = calendar.dateComponents([.year, .month], from: job.periodTo ?? Date())
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 13) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: "\(compFrom.year ?? 0) - \(compTo.year ?? 0)", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += textString.size().height
            
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 11) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: job.company ?? "", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY + 5, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += textString.size().height
            
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 10) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: job.position ?? "", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY + 5, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += ceil(textString.size().width/(pageRect.width-40))*textString.size().height + 15
            
        }
        positionY += 5
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: textRect.minX, y: positionY))
        context.addLine(to: CGPoint(x: textRect.maxX-20, y: positionY))
        context.setStrokeColor(CGColor(red: 11/255, green: 181/255, blue: 244/255, alpha: 1))
        context.strokePath()
        
        positionY += 20
        
        headerString = NSAttributedString(string: "VZDĚLÁNÍ", attributes: sectionHeaderAttributes)
        headerRect = CGRect(x: pageRect.minX+20, y: positionY, width: headerString.size().width, height: headerString.size().height)
        headerString.draw(in: headerRect)
        positionY += 30
        
        for school in person.schoolArray {
            let calendar = Calendar.current
            let compFrom = calendar.dateComponents([.year, .month], from: school.periodFrom ?? Date())
            let compTo = calendar.dateComponents([.year, .month], from: school.periodTo ?? Date())
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 13) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: "\(compFrom.year ?? 0) - \(compTo.year ?? 0)", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += ceil(textString.size().width/(pageRect.width-40))*textString.size().height
            
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 11) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: school.school ?? "", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY + 5, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += ceil(textString.size().width/(pageRect.width-40))*textString.size().height
            
            sectionTextAttributes = [.font: UIFont(name: "HelveticaNeue", size: 10) as Any, .foregroundColor: UIColor.black, .paragraphStyle: sectionTextStyle]
            textString = NSAttributedString(string: school.course ?? "", attributes: sectionTextAttributes)
            textRect = CGRect(x: headerRect.minX, y: positionY + 5, width: pageRect.width - 20, height: ceil(textString.size().width/(pageRect.width-40))*textString.size().height)
            textString.draw(in: textRect)
            positionY += ceil(textString.size().width/(pageRect.width-40))*textString.size().height + 15
            
        }
        
        positionY += 5
        context.setLineWidth(1.0)
        context.move(to: CGPoint(x: textRect.minX, y: positionY))
        context.addLine(to: CGPoint(x: textRect.maxX-20, y: positionY))
        context.setStrokeColor(CGColor(red: 11/255, green: 181/255, blue: 244/255, alpha: 1))
        context.strokePath()
        
        positionY += 20
        
        headerString = NSAttributedString(string: "ZÁLIBY", attributes: sectionHeaderAttributes)
        headerRect = CGRect(x: pageRect.minX+20, y: positionY, width: headerString.size().width, height: headerString.size().height)
        headerString.draw(in: headerRect)
        positionY += 30
        
        var positionX = pageRect.minX+20
        let maxX = textRect.maxX-20
        let diff = (maxX - positionX)/CGFloat(person.hobbyArray.count)
        
        for hobby in person.hobbyArray {
            let icon = NSTextAttachment()
            icon.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            
            icon.image = UIImage(named: hobby.name ?? "")
            let iconString = NSAttributedString(attachment: icon)
            
            let iconRect = CGRect(x: positionX, y: positionY, width: iconString.size().width, height: iconString.size().height)
            iconString.draw(in: iconRect)
            positionX += diff
        }
    }
    
    private func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
    /*  // 1
        let maxHeight = pageRect.height * 0.3 //0.4
        let maxWidth = pageRect.width * 0.3 //0.8
      // 2
      let aspectWidth = maxWidth / image.size.width
      let aspectHeight = maxHeight / image.size.height
      let aspectRatio = min(aspectWidth, aspectHeight)*/
      // 3
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let imgFile =  paths[0].relativePath + "/" + (person.img ?? "")
        let image = UIImage(contentsOfFile: imgFile) ?? UIImage()
        let scaledWidth = CGFloat(200)//image.size.width
        let scaledHeight = scaledWidth//mage.size.height
      // 4
      //let imageX = (pageRect.width - scaledWidth) / 2.0
        let imageRect = CGRect(x: 0, y: imageTop,
                             width: scaledWidth, height: scaledHeight)
      // 5
      image.draw(in: imageRect)
      return imageRect.origin.y + imageRect.size.height + 20
    }
    
}
