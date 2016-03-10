//
//  main.swift
//  freecell.swift
//
//  Created by Alex Weisberger on 3/9/16.
//  Copyright © 2016 AMW. All rights reserved.
//

import Foundation


func get_input() -> String? {
    print("Enter move:")
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    return NSString(data: inputData, encoding:NSUTF8StringEncoding) as? String
}

// game_state_new = f(move, game_state)
func main() {
    let cascades = create_cascades()
    let free_cells = [Card]()
    let foundations = [Card]()
    
    let game_state = GameState(
        cascades: cascades,
        free_cells: free_cells,
        foundations: foundations
    )
    
    var input = ""
    while input != "q\n" {
        print("")
        game_state.render()
        if let raw_input = get_input() {
            input = raw_input
            
            if let move = move_from_input(raw_input) {
                game_state.perform_move(move)
            } else {
                print("Unrecognized command")
            }
        }
    }
}

main()

