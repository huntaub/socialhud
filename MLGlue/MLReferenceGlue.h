/*
 * MLReferenceGlue.h
 * /Applications/Mail.app
 * osaglue 0.5.2
 *
 */

#import <Foundation/Foundation.h>
#import "Appscript/Appscript.h"
#import "MLCommandGlue.h"
#import "MLReferenceRendererGlue.h"
#define MLApp ((MLReference *)[MLReference referenceWithAppData: nil aemReference: AEMApp])
#define MLCon ((MLReference *)[MLReference referenceWithAppData: nil aemReference: AEMCon])
#define MLIts ((MLReference *)[MLReference referenceWithAppData: nil aemReference: AEMIts])

@interface MLReference : ASReference

/* +app, +con, +its methods can be used in place of MLApp, MLCon, MLIts macros */

+ (MLReference *)app;
+ (MLReference *)con;
+ (MLReference *)its;

/* ********************************* */

- (NSString *)description;

/* Commands */

- (MLGetURLCommand *)GetURL;
- (MLGetURLCommand *)GetURL:(id)directParameter;
- (MLActivateCommand *)activate;
- (MLActivateCommand *)activate:(id)directParameter;
- (MLBounceCommand *)bounce;
- (MLBounceCommand *)bounce:(id)directParameter;
- (MLCheckForNewMailCommand *)checkForNewMail;
- (MLCheckForNewMailCommand *)checkForNewMail:(id)directParameter;
- (MLCloseCommand *)close;
- (MLCloseCommand *)close:(id)directParameter;
- (MLCountCommand *)count;
- (MLCountCommand *)count:(id)directParameter;
- (MLDeleteCommand *)delete;
- (MLDeleteCommand *)delete:(id)directParameter;
- (MLDuplicateCommand *)duplicate;
- (MLDuplicateCommand *)duplicate:(id)directParameter;
- (MLExistsCommand *)exists;
- (MLExistsCommand *)exists:(id)directParameter;
- (MLExtractAddressFromCommand *)extractAddressFrom;
- (MLExtractAddressFromCommand *)extractAddressFrom:(id)directParameter;
- (MLExtractNameFromCommand *)extractNameFrom;
- (MLExtractNameFromCommand *)extractNameFrom:(id)directParameter;
- (MLForwardCommand *)forward;
- (MLForwardCommand *)forward:(id)directParameter;
- (MLGetCommand *)get;
- (MLGetCommand *)get:(id)directParameter;
- (MLImportMailMailboxCommand *)importMailMailbox;
- (MLImportMailMailboxCommand *)importMailMailbox:(id)directParameter;
- (MLLaunchCommand *)launch;
- (MLLaunchCommand *)launch:(id)directParameter;
- (MLMailtoCommand *)mailto;
- (MLMailtoCommand *)mailto:(id)directParameter;
- (MLMakeCommand *)make;
- (MLMakeCommand *)make:(id)directParameter;
- (MLMoveCommand *)move;
- (MLMoveCommand *)move:(id)directParameter;
- (MLOpenCommand *)open;
- (MLOpenCommand *)open:(id)directParameter;
- (MLOpenLocationCommand *)openLocation;
- (MLOpenLocationCommand *)openLocation:(id)directParameter;
- (MLPerformMailActionWithMessagesCommand *)performMailActionWithMessages;
- (MLPerformMailActionWithMessagesCommand *)performMailActionWithMessages:(id)directParameter;
- (MLPrintCommand *)print;
- (MLPrintCommand *)print:(id)directParameter;
- (MLQuitCommand *)quit;
- (MLQuitCommand *)quit:(id)directParameter;
- (MLRedirectCommand *)redirect;
- (MLRedirectCommand *)redirect:(id)directParameter;
- (MLReopenCommand *)reopen;
- (MLReopenCommand *)reopen:(id)directParameter;
- (MLReplyCommand *)reply;
- (MLReplyCommand *)reply:(id)directParameter;
- (MLRunCommand *)run;
- (MLRunCommand *)run:(id)directParameter;
- (MLSaveCommand *)save;
- (MLSaveCommand *)save:(id)directParameter;
- (MLSend_Command *)send_;
- (MLSend_Command *)send_:(id)directParameter;
- (MLSetCommand *)set;
- (MLSetCommand *)set:(id)directParameter;
- (MLSynchronizeCommand *)synchronize;
- (MLSynchronizeCommand *)synchronize:(id)directParameter;

/* Elements */

- (MLReference *)MacAccounts;
- (MLReference *)MobileMeAccounts;
- (MLReference *)OLDMessageEditors;
- (MLReference *)accounts;
- (MLReference *)applications;
- (MLReference *)attachments;
- (MLReference *)attributeRuns;
- (MLReference *)bccRecipients;
- (MLReference *)ccRecipients;
- (MLReference *)characters;
- (MLReference *)colors;
- (MLReference *)containers;
- (MLReference *)documents;
- (MLReference *)headers;
- (MLReference *)imapAccounts;
- (MLReference *)items;
- (MLReference *)ldapServers;
- (MLReference *)mailAttachments;
- (MLReference *)mailboxes;
- (MLReference *)messageViewers;
- (MLReference *)outgoingMessages;
- (MLReference *)paragraphs;
- (MLReference *)popAccounts;
- (MLReference *)recipients;
- (MLReference *)ruleConditions;
- (MLReference *)rules;
- (MLReference *)signatures;
- (MLReference *)smtpServers;
- (MLReference *)text;
- (MLReference *)toRecipients;
- (MLReference *)windows;
- (MLReference *)words;

/* Properties */

- (MLReference *)MIMEType;
- (MLReference *)_0x28OLD0x29ComposeMessage_;
- (MLReference *)account;
- (MLReference *)accountDirectory;
- (MLReference *)accountType;
- (MLReference *)address;
- (MLReference *)allConditionsMustBeMet;
- (MLReference *)allHeaders;
- (MLReference *)alwaysBccMyself;
- (MLReference *)alwaysCcMyself;
- (MLReference *)applicationVersion;
- (MLReference *)authentication;
- (MLReference *)backgroundActivityCount;
- (MLReference *)backgroundColor;
- (MLReference *)bigMessageWarningSize;
- (MLReference *)bounds;
- (MLReference *)checkSpellingWhileTyping;
- (MLReference *)chooseSignatureWhenComposing;
- (MLReference *)class_;
- (MLReference *)closeable;
- (MLReference *)color;
- (MLReference *)colorMessage;
- (MLReference *)colorQuotedText;
- (MLReference *)compactMailboxesWhenClosing;
- (MLReference *)container;
- (MLReference *)content;
- (MLReference *)copyMessage;
- (MLReference *)dateReceived;
- (MLReference *)dateSent;
- (MLReference *)defaultMessageFormat;
- (MLReference *)delayedMessageDeletionInterval;
- (MLReference *)deleteMailOnServer;
- (MLReference *)deleteMessage;
- (MLReference *)deleteMessagesWhenMovedFromInbox;
- (MLReference *)deletedStatus;
- (MLReference *)deliveryAccount;
- (MLReference *)downloadHtmlAttachments;
- (MLReference *)downloaded;
- (MLReference *)draftsMailbox;
- (MLReference *)emailAddresses;
- (MLReference *)emptyJunkMessagesFrequency;
- (MLReference *)emptyJunkMessagesOnQuit;
- (MLReference *)emptySentMessagesFrequency;
- (MLReference *)emptySentMessagesOnQuit;
- (MLReference *)emptyTrashFrequency;
- (MLReference *)emptyTrashOnQuit;
- (MLReference *)enabled;
- (MLReference *)expandGroupAddresses;
- (MLReference *)expression;
- (MLReference *)fetchInterval;
- (MLReference *)fetchesAutomatically;
- (MLReference *)fileName;
- (MLReference *)fileSize;
- (MLReference *)fixedWidthFont;
- (MLReference *)fixedWidthFontSize;
- (MLReference *)flaggedStatus;
- (MLReference *)floating;
- (MLReference *)font;
- (MLReference *)forwardMessage;
- (MLReference *)forwardText;
- (MLReference *)frameworkVersion;
- (MLReference *)frontmost;
- (MLReference *)fullName;
- (MLReference *)header;
- (MLReference *)headerDetail;
- (MLReference *)highlightSelectedThread;
- (MLReference *)highlightTextUsingColor;
- (MLReference *)hostName;
- (MLReference *)hostsToLogActivityOn;
- (MLReference *)htmlContent;
- (MLReference *)id_;
- (MLReference *)inbox;
- (MLReference *)includeAllOriginalMessageText;
- (MLReference *)includeWhenGettingNewMail;
- (MLReference *)index;
- (MLReference *)junkMailStatus;
- (MLReference *)junkMailbox;
- (MLReference *)levelOneQuotingColor;
- (MLReference *)levelThreeQuotingColor;
- (MLReference *)levelTwoQuotingColor;
- (MLReference *)logAllSocketActivity;
- (MLReference *)logMessages;
- (MLReference *)mailbox;
- (MLReference *)mailboxListVisible;
- (MLReference *)markFlagged;
- (MLReference *)markRead;
- (MLReference *)memoryStatistics;
- (MLReference *)messageCaching;
- (MLReference *)messageFont;
- (MLReference *)messageFontSize;
- (MLReference *)messageId;
- (MLReference *)messageListFont;
- (MLReference *)messageListFontSize;
- (MLReference *)messageSignature;
- (MLReference *)messageSize;
- (MLReference *)messages;
- (MLReference *)miniaturizable;
- (MLReference *)miniaturized;
- (MLReference *)modal;
- (MLReference *)modified;
- (MLReference *)moveDeletedMessagesToTrash;
- (MLReference *)moveMessage;
- (MLReference *)name;
- (MLReference *)newMailSound;
- (MLReference *)outbox;
- (MLReference *)password;
- (MLReference *)path;
- (MLReference *)playSound;
- (MLReference *)port;
- (MLReference *)portsToLogActivityOn;
- (MLReference *)previewPaneIsVisible;
- (MLReference *)primaryEmail;
- (MLReference *)properties;
- (MLReference *)qualifier;
- (MLReference *)quoteOriginalMessage;
- (MLReference *)readStatus;
- (MLReference *)redirectMessage;
- (MLReference *)replyText;
- (MLReference *)replyTo;
- (MLReference *)resizable;
- (MLReference *)ruleType;
- (MLReference *)runScript;
- (MLReference *)sameReplyFormat;
- (MLReference *)scope;
- (MLReference *)searchBase;
- (MLReference *)selectedMailboxes;
- (MLReference *)selectedMessages;
- (MLReference *)selectedSignature;
- (MLReference *)selection;
- (MLReference *)sender;
- (MLReference *)sentMailbox;
- (MLReference *)serverName;
- (MLReference *)shouldCopyMessage;
- (MLReference *)shouldMoveMessage;
- (MLReference *)shouldPlayOtherMailSounds;
- (MLReference *)showOnlineBuddyStatus;
- (MLReference *)size;
- (MLReference *)sortColumn;
- (MLReference *)sortedAscending;
- (MLReference *)source;
- (MLReference *)stopEvaluatingRules;
- (MLReference *)storeDeletedMessagesOnServer;
- (MLReference *)storeDraftsOnServer;
- (MLReference *)storeJunkMailOnServer;
- (MLReference *)storeSentMessagesOnServer;
- (MLReference *)subject;
- (MLReference *)titled;
- (MLReference *)trashMailbox;
- (MLReference *)unreadCount;
- (MLReference *)useAddressCompletion;
- (MLReference *)useFixedWidthFont;
- (MLReference *)useKeychain;
- (MLReference *)userName;
- (MLReference *)usesSsl;
- (MLReference *)vcardPath;
- (MLReference *)version_;
- (MLReference *)visible;
- (MLReference *)visibleColumns;
- (MLReference *)visibleMessages;
- (MLReference *)wasForwarded;
- (MLReference *)wasRedirected;
- (MLReference *)wasRepliedTo;
- (MLReference *)window;
- (MLReference *)zoomable;
- (MLReference *)zoomed;

/* ********************************* */


/* ordinal selectors */

- (MLReference *)first;
- (MLReference *)middle;
- (MLReference *)last;
- (MLReference *)any;

/* by-index, by-name, by-id selectors */

- (MLReference *)at:(int)index;
- (MLReference *)byIndex:(id)index;
- (MLReference *)byName:(id)name;
- (MLReference *)byID:(id)id_;

/* by-relative-position selectors */

- (MLReference *)previous:(ASConstant *)class_;
- (MLReference *)next:(ASConstant *)class_;

/* by-range selector */

- (MLReference *)at:(int)fromIndex to:(int)toIndex;
- (MLReference *)byRange:(id)fromObject to:(id)toObject;

/* by-test selector */

- (MLReference *)byTest:(MLReference *)testReference;

/* insertion location selectors */

- (MLReference *)beginning;
- (MLReference *)end;
- (MLReference *)before;
- (MLReference *)after;

/* Comparison and logic tests */

- (MLReference *)greaterThan:(id)object;
- (MLReference *)greaterOrEquals:(id)object;
- (MLReference *)equals:(id)object;
- (MLReference *)notEquals:(id)object;
- (MLReference *)lessThan:(id)object;
- (MLReference *)lessOrEquals:(id)object;
- (MLReference *)beginsWith:(id)object;
- (MLReference *)endsWith:(id)object;
- (MLReference *)contains:(id)object;
- (MLReference *)isIn:(id)object;
- (MLReference *)AND:(id)remainingOperands;
- (MLReference *)OR:(id)remainingOperands;
- (MLReference *)NOT;
@end

