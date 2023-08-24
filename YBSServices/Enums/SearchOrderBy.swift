//
//  SearchByOrder.swift
//  YBSServices
//
//  Created by Lenard Pop on 24/08/2023.
//

public enum SearchOrderBy: String {
    case Relevance = "Relevance"
    case DateTakenAsc = "DateTakenAsc"
    case DateTakenDesc = "DateTakenDesc"
    case Interesting = "InterestingAsc"

    public func equal(to otherType: SearchOrderBy) -> Bool {
        return self == otherType
    }
}
