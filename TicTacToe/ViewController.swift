//
//  ViewController.swift
//  TicTacToe
//
//  Created by user on 1/8/17.
//  Copyright © 2017 vuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var buttons: UIView!
    @IBOutlet weak var endBtn: UIButton!
    
    let numOfColumns=3
    let numOfRows=3
    var array=Array<Array<String>>()
    
    
    
    @IBAction func OnStartClick(_ sender: UIButton) {
        
        buttons.isHidden=false
        
        let initialFrame=buttons.frame
        let bounds = buttons.bounds
        let startFrame = initialFrame.offsetBy(dx: 0, dy: bounds.size.height)
        let finalFrame=buttons.frame
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                self.buttons.frame = startFrame
                self.resetGame()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.buttons.frame = finalFrame
            }
        }, completion: nil)
        
    }
    @IBAction func onEndClick(_ sender: UIButton) {
        buttons.isHidden=true
        resetGame()
    }
    
    @IBAction func onResetClick(_ sender: UIButton) {
        let bounds = buttons.bounds
        let startFrameReveal = buttons.frame.offsetBy(dx: 0, dy: bounds.size.height)
        let finalFrameReveal=buttons.frame
        
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
            //odi dole
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.buttons.frame = startFrameReveal
            }
            //odi gore
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.buttons.frame = finalFrameReveal
                self.resetGame()
            }
        }, completion: nil)
        
    }
    
    let markX:String="X"
    let markO:String="O"
    var player:String="O"
    
    @IBAction func onBtnClick(_ sender: UIButton) {
        let tag=sender.tag
        print("Novost")
        print(player)
        
        if let btnText=sender.titleLabel, let text=btnText.text{
            //Promijeni vrijednosti na ploci
            //prvi igra igrac X
    
            switch text{
            case markX:
                //na redu je X
                print(sender.currentTitle! )
                sender.setTitle(markO, for: [])
                print(sender.currentTitle! )
                print("Treba biti O")
                //  print(markO )
                
                player=markO
            case markO:
                //na redu je Y
                print(sender.currentTitle! )
                sender.setTitle(markX, for: [])
                print(sender.currentTitle! )
                print("Treba biti X")
                //   print(markX )
                
                player=markX
            default:
                print("error kod mijenjanja vrijednosti na kliknutom buttonu igre")
            }
        }
        
        //Upisi korisnikov odabir u polje
        switch tag {
        case 11:
            array[0][0]=player
        case 12:
            array[0][1]=player
        case 13:
            array[0][2]=player
        case 21:
            array[1][0]=player
        case 22:
            array[1][1]=player
        case 23:
            array[1][2]=player
        case 31:
            array[2][0]=player
        case 32:
            array[2][1]=player
        case 33:
            array[2][2]=player
        default:
            print("error kod upisivanja vrijednosti u polje")
        }
        
        // checkWinner()
    }
    
    func checkWinner(){
        
        let isWinnerHorizontal=checkHorizontal()
        if(isWinnerHorizontal){
            //showWinnerMsg(winner:"brat")
            return
        }
        
        let isWinnerVertical=checkVertical()
        if(isWinnerVertical){
            return
        }
        
        let isWinnerDiagonally=checkDiagonally()
        if(isWinnerDiagonally){
            return
        }
        
    }
    
    func checkHorizontal()->Bool{
        var lastElement:String="Winner is error! he he"
        
        for i in 0..<3{
            var row=array[i]
            print(row)
            
            lastElement=row[0]
            
            for el in 0..<row.count{
                
                let element=row[el]
                if (element != "" && element == lastElement) {
                    //ako je nesto postavljeno i to nesto je isto kao i zadnji element
                    lastElement=element
                    print(lastElement)
                }else{
                    print("oso u false: el "+element+" last "+lastElement)
                    break
                }
                
                //imamo pobjednika
                return true;
            }
        }
        return false
    }
    func checkVertical()->Bool{
        
        //showWinnerMsg(winner:"ne")
        return false
    }
    
    func checkDiagonally()->Bool{
        
        // showWinnerMsg(winner:"ne")
        return false
    }
    
    func showWinnerMsg(winner:String){
        alert(title:"Winner",msg: "Winner is player \(winner)")
    }
    
    
    func resetGame(){
        
        for _ in 0..<3 {
            array.append(Array(repeating:"",count:numOfColumns))
        }
        
        //dohvati horizontal stack viewe
        for subview in buttons.subviews {
            //kroz svaki stack view
            for view in subview.subviews {
                //dohvati button
                if let btn = view as? UIButton {
                    btn.setTitle("", for: .normal)
                    //resetiraj button text
                }
            }
            
        }
    }
    
    func alert(title:String,msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

