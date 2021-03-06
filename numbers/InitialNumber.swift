import SpriteKit

class InitailNumbers {
    
    
    var sizeForEachHorizontalRow:CGFloat = 0
    var firstRowNumber = 0
    var secondRowNumber = 0
    var sizeForEachVerticalRow:CGFloat = 0
    
    
    var firtsLabelShape = SKSpriteNode()
    var secondLabelShape = SKShapeNode()
    
    var firstLabel = SKLabelNode()
    var secondLabel = SKLabelNode()
    
    
    init (x:CGFloat, scene: GameScene){
        
        self.createNumbers()
        
        self.firstLabel.text = String(self.firstRowNumber)
        self.secondLabel.text = String(self.secondRowNumber)
        
        self.sizeForEachVerticalRow = scene.sizeForEachVerticalRow
        self.sizeForEachHorizontalRow = scene.sizeForEachVerticalRow
        
        self.firtsLabelShape.position = CGPoint(x: x, y: sizeForEachHorizontalRow / 2)
        self.secondLabelShape.position = CGPoint(x: x, y: sizeForEachHorizontalRow  + 25 )
    
    
        self.firstLabel.horizontalAlignmentMode = .center
        self.firstLabel.verticalAlignmentMode = .center
        self.secondLabel.horizontalAlignmentMode = .center
        self.secondLabel.verticalAlignmentMode = .center
        
        self.secondLabelShape.path = UIBezierPath(roundedRect: CGRect(x: -sizeForEachVerticalRow / 2 + 2.5, y: -sizeForEachVerticalRow / 2, width: sizeForEachVerticalRow - 5, height: sizeForEachVerticalRow), cornerRadius: CGFloat(sizeForEachVerticalRow / 2)).cgPath
        
    
        self.firtsLabelShape.zPosition = 3
        self.secondLabelShape.zPosition = 3
        self.firstLabel.zPosition = 5
        self.secondLabel.zPosition = 5
        
        self.firtsLabelShape.addChild(self.firstLabel)
        self.secondLabelShape.addChild(self.secondLabel)
        scene.addChild(self.firtsLabelShape)
        scene.addChild(self.secondLabelShape)
    }
    
    func createNumbers() {
        self.firstRowNumber = randomInt(-10, max: 10)
        self.secondRowNumber = randomInt(-15, max: 15)
        if  self.firstRowNumber == self.secondRowNumber {
            if self.secondRowNumber == -15 {
                self.secondRowNumber += 1
            } else if self.secondRowNumber == 15 {
                self.secondRowNumber -= 1
            } else {
                self.secondRowNumber += 1
            }
        }
    }
    
    func victory () -> Bool {
        var check = 0
        for i in 0..<GameScene.arrayOfStartNumbers.count {
            if GameScene.arrayOfStartNumbers[i].firstRowNumber == GameScene.arrayOfStartNumbers[i].secondRowNumber {
                check += 1
            }
        }
        
        if check == GameScene.arrayOfStartNumbers.count {
            return true
        } else {
            return false
        }
    }
    
    func refreshValue (_ fallingNumber: Int, scene: GameScene) {
        self.secondRowNumber += fallingNumber
        self.secondLabel.text = String(self.secondRowNumber)
        if self.secondRowNumber > 15 || self.secondRowNumber < -15 {
            scene.gameOver()
        } else if (self.secondRowNumber == self.firstRowNumber ){
            self.secondLabelShape.path = UIBezierPath(rect: CGRect(x: -sizeForEachVerticalRow / 2 + 2.5, y: -sizeForEachVerticalRow / 2, width: sizeForEachVerticalRow - 5, height: sizeForEachVerticalRow)).cgPath
        } else if (self.secondRowNumber != self.firstRowNumber ){
            self.secondLabelShape.path = UIBezierPath(roundedRect: CGRect(x: -sizeForEachVerticalRow / 2 + 2.5, y: -sizeForEachVerticalRow / 2, width: sizeForEachVerticalRow - 5, height: sizeForEachVerticalRow), cornerRadius: CGFloat(sizeForEachVerticalRow / 2)).cgPath
        }
        
        if victory() {
            scene.gameOver()
        }
    }
}
