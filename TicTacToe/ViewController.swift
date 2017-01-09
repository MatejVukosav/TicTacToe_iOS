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
    @IBOutlet weak var onTurnLabel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    
    
    
    let numOfColumns=3
    let numOfRows=3
    var array=Array<Array<String>>()
    
    let markX:String="X"
    let markO:String="O"
    var lastPlayer:String = ""
    var playerOnTurn:String = ""
    
    override func viewDidLoad() {
        initGame()
    }
    
    @IBAction func OnStartClick(_ sender: UIButton) {
        startGame()
        
        let initialFrame=buttons.frame
        let bounds = buttons.bounds
        let startFrame = initialFrame.offsetBy(dx: 0, dy: bounds.size.height)
        let finalFrame=buttons.frame
        
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.0) {
                self.buttons.frame = startFrame
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.buttons.frame = finalFrame
            }
        }, completion: nil)
        
    }
    @IBAction func onEndClick(_ sender: UIButton) {
        endGame()
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
    
    
    @IBAction func onBtnClick(_ sender: UIButton) {
        let tag=sender.tag
        
        lastPlayer=playerOnTurn
        print(lastPlayer)
        
        var text:String=playerOnTurn
        
        //kad stavim nesto na 11 i resetiram igru, 11 mi i dalje ima vrijednost, tj prode unutar if-a why??
//        if let btnLabel=sender.titleLabel, let btnText=btnLabel.text{
//            //odigran je X, znaci na redu je O
//            text=btnText
//        }else{
//            //Promijeni vrijednosti na ploci
//            //prvi igra igrac X
//            text=playerOnTurn
//        }
        
        switch text{
        case markX:
            //na redu je X
            sender.setTitle(markX, for: [])
            lastPlayer=markX
            playerOnTurn=markO
        case markO:
            //na redu je Y
            sender.setTitle(markO, for: [])
            lastPlayer=markO
            playerOnTurn=markX
        default:
            print("error kod mijenjanja vrijednosti na kliknutom buttonu igre")
        }
        
        
        //Upisi korisnikov odabir u polje
        switch tag {
        case 11:
            array[0][0]=lastPlayer
        case 12:
            array[0][1]=lastPlayer
        case 13:
            array[0][2]=lastPlayer
        case 21:
            array[1][0]=lastPlayer
        case 22:
            array[1][1]=lastPlayer
        case 23:
            array[1][2]=lastPlayer
        case 31:
            array[2][0]=lastPlayer
        case 32:
            array[2][1]=lastPlayer
        case 33:
            array[2][2]=lastPlayer
        default:
            print("error kod upisivanja vrijednosti u polje")
        }
        sender.isEnabled=false
        
        checkWinner()
        playerName.text=playerOnTurn
        print(array)
    }
    
    func checkWinner(){
        
        var status=checkHorizontal()
        if(status.isWinner){
            print("Winner horizontalno je \(status.player)")
            showWinnerMsg(winner:status.player)
            return
        }
        
        status=checkVertical()
        if(status.isWinner){
            print("Winner vertikalno je \(status.player)")
            showWinnerMsg(winner:status.player)
            
            return
        }
        
        status=checkDiagonallyLeftToRight()
        if(status.isWinner){
            print("Winner dijagonala s lijeva nadesno je \(status.player)")
            showWinnerMsg(winner:status.player)
            return
        }
        
        
        status=checkDiagonallyRightToLeft()
        if(status.isWinner){
            print("Winner dijagonala s desna nalijevo je \(status.player)")
            showWinnerMsg(winner:status.player)
            return
        }
        
    }
    
    func checkHorizontal()->(isWinner:Bool,player:String){
        var lastElement:String="Winner is error! he he"
        
        for i in 0..<3{
            var row=array[i]
            
            lastElement=row[0]
            
            for el in 0..<row.count{
                
                let element=row[el]
                if (element == "" || element != lastElement) {
                    break
                }
                
                if(el+1==row.count){
                    //imamo pobjednika
                    return (true,lastElement);
                }
            }
        }
        return (false,"")
    }
    
    func checkVertical()->(isWinner:Bool,player:String){
        var first:String
        
        for i in 0..<numOfColumns{
            first=array[0][i]
            
            for row in 0..<numOfRows{
                
                let element=array[row][i]
                if(element == "" || element != first ){
                    break
                }
                
                if(row==numOfRows-1){
                    return (true,first)
                }
            }
        }
        return (false,"")
    }
    
    func checkDiagonallyLeftToRight()->(isWinner:Bool,player:String){
        
        let firstLeft=array[0][0]
        //check from left to right
        for i in 1..<numOfRows{
            let element=array[i][i]
            
            if(element == "" || element != firstLeft ){
                return (false,"")
            }
            
        }
        
        return (true,firstLeft)
    }
    
    func checkDiagonallyRightToLeft()->(isWinner:Bool,player:String){
        
        let lastRight=array[0][numOfColumns-1]
        //check from right to left
        for i in stride(from: numOfRows-1, through: 0, by: -1){
            let element=array[numOfRows-1-i][i]
            
            if(element == "" || element != lastRight ){
                return (false,"")
            }
        }
        
        return (true,lastRight)
    }
    
    
    func showWinnerMsg(winner:String){
        alert(title:"Winner",msg: "Winner is player \(winner)")
    }
    
    func initGame(){
        for _ in 0..<numOfRows{
            array.append(Array(repeating:"",count:numOfColumns))
        }
        startBtn.isHidden=false
        buttons.isHidden=true
        endBtn.isHidden=true
        resetBtn.isHidden=true
        onTurnLabel.isHidden=true
    }
    
    func startGame(){
        for i in 0..<numOfRows {
            for j in 0..<numOfColumns{
                array[i][j]=""
            }
        }
        startBtn.isHidden=true
        buttons.isHidden=false
        endBtn.isHidden=false
        resetBtn.isHidden=false
        onTurnLabel.isHidden=false
        playerName.isHidden=false
        playerOnTurn=markX
        lastPlayer=markO
        playerName.text=playerOnTurn
    }
    
    func endGame(){
        startBtn.isHidden=false
        endBtn.isHidden=true
        resetBtn.isHidden=true
        buttons.isHidden=true
        onTurnLabel.isHidden=true
        playerName.isHidden=true
        resetGame()
    }
    
    
    func resetGame(){
        playerOnTurn=markX
        lastPlayer=markO
        playerName.text=playerOnTurn
        
        for i in 0..<numOfRows {
            for j in 0..<numOfColumns{
                array[i][j]=""
            }
        }
        
        //dohvati horizontal stack viewe
        for subview in buttons.subviews {
            //kroz svaki stack view
            for view in subview.subviews {
                //dohvati button
                if let btn = view as? UIButton {
                    btn.setTitle(nil, for: [])
                    btn.isEnabled=true
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

