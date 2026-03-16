//
//  SupabaseManager.swift
//  Food
//
//  Created by Janzen Houchen-Wilder on 3/11/26.
//

import Foundation
import Supabase

final class SupabaseManager {
    static let shared = SupabaseManager()

    let client: SupabaseClient

    private init() {
        let urlString = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as! String
        let key = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as! String
        
        client = SupabaseClient(
            supabaseURL: URL(string: urlString)!,
            supabaseKey: key
        )
    }
}
