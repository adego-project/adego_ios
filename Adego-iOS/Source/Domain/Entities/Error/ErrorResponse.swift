//
//  ErrorResponse.swift
//  Adego-iOS
//
//  Created by 최시훈 on 7/9/24.
//

import Foundation

struct ErrorResponse: Error, Codable {
    let statusCode: Int
    let message: String
    
    /// 상태 코드에 따른 설명 메시지를 반환하는 메서드
    func responseMessage() -> String {
        switch statusCode {
        case 400:
            return "잘못된 요청입니다. 서버가 클라이언트의 요청을 이해할 수 없습니다."
        case 401:
            return "인증이 만료되었습니다. 다시 로그인하세요."
        case 403:
            return "금지된 요청입니다. 해당 콘텐츠에 접근할 권한이 없습니다."
        case 404:
            return "페이지를 찾을 수 없습니다. 요청한 리소스가 존재하지 않습니다."
        case 405:
            return "허용되지 않은 메서드입니다. 요청한 메서드는 서버에서 허용되지 않습니다."
        case 409:
            return "요청이 서버의 상태와 충돌했습니다. 잠시후 다시 실행해주세요."
        case 500:
            return "서버 내부 오류가 발생했습니다. 잠시후 다시 실행해주세요."
        case 502:
            return "잘못된 게이트웨이입니다. 잠시후 다시 실행해주세요."
        case 503:
            return "서비스를 사용할 수 없습니다. 서버가 일시적으로 과부하 상태이거나 유지 보수 중입니다."
        case 504:
            return "게이트웨이 시간 초과입니다. 서버가 요청을 제 시간에 응답하지 못했습니다."
        default:
            return "알 수 없는 오류가 발생했습니다. 나중에 다시 시도하세요."
        }
    }
}
