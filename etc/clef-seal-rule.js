/**
 * A simple clef rule that only allows the clef instance to sign clique transactions.
 */
function OnSignerStartup(info) {}

function ApproveListing() {
    return "Approve"
}

function ApproveSignData(r) {
    if (r.content_type == "application/x-clique-header") {
        for (var i = 0; i < r.messages.length; i++) {
            var msg = r.messages[i]
            if (msg.name.toLowerCase() == "clique header" && msg.type == "clique") {
                return "Approve"
            }
        }
    }
    return "Reject"
}