unit Mir3ServerXMLResourceReader;

interface

uses WinAPI.Windows, System.SysUtils, System.StrUtils, System.Classes,
     System.Generics.Collections, Xml.XMLDoc, Xml.xmldom, XML.XMLIntf,

     WinAPI.msxml, Mir3ServerCore;

type
  PXMLArtisanLevelNode = ^TXMLArtisanLevelNode;
  TXMLArtisanLevelNode = record  //Craftsman
    RArtisanLevel : Integer;
    RAccuEXP      : Integer;
    RNeedEXP      : Integer;
    RMax_AP       : Integer;
  end;

  PXMLEtcSrciptNode = ^TXMLEtcSrciptNode;
  TXMLEtcSrciptNode = record
    REtcID        : Integer;
    RName         : String;
    RKoreaName    : String;
  end;

  PXMLGuardListNode = ^TXMLGuardListNode;
  TXMLGuardListNode = record
    RMonID        : Integer;
    RMapID        : Integer;
    RMapX         : Integer;
    RMapY         : Integer;
    RDirection    : Integer;
  end;

  PXMLMagicNode = ^TXMLMagicNode;
  TXMLMagicNode = record
    RMagicID      : Integer;
    RMagicName    : String;
    RMagicType    : Integer;
    REffectType   : Integer;
    REffect       : Integer;
    RSpellID      : Integer;
    RPower        : Integer;
    RMaxPower     : Integer;
    RDefSpell     : Integer;
    RDefPower     : Integer;
    RDefMaxPower  : Integer;
    RJobID        : Integer;
    RPhase        : Integer;
    RNeedLevel_1  : Integer;
    RTrainLevel_1 : Integer;
    RNeedLevel_2  : Integer;
    RTrainLevel_2 : Integer;
    RNeedLevel_3  : Integer;
    RTrainLevel_3 : Integer;
    RNeedLevel_4  : Integer;
    RTrainLevel_4 : Integer;
    RNeedLevel_5  : Integer;
    RTrainLevel_5 : Integer;
    RDelay        : Integer;
    RCoolTime     : Integer;
    RKoreaName    : String;
    RSkillType    : Integer;
    RToolTip      : String;
  end;

  PXMLMapInfoNode = ^TXMLMapInfoNode;
  TXMLMapInfoNode = record
    RMapID        : Integer;
    RMapName      : String;
    RMapTitle     : String;
    RServerID     : Integer;
    RCHNServerID  : Integer;
    RNeedLevel    : Integer;
    RTime         : Integer;
    RWeather      : Integer;
    RVehicle      : Integer;
    RPVP          : Boolean;
    RMine         : Boolean;
    REnterLevel   : Integer;
    REnterQuest   : Integer;
    REnterItem    : Integer;
    RNoReconnect  : Integer;
    RMiniMap      : Integer;
    RControl      : String;
    RVersion      : Integer;
    RApplyRow     : Integer; //?
    RMapExpRatio  : Integer; //Int or Float?
    RMapDropRatio : Integer; //Int or Float?
    RMapMoneyRatio: Integer; //Int or Float?
    ROrderList    : Integer; //Int or Bool?
  end;

  PXMLMapLinkNode = ^TXMLMapLinkNode;
  TXMLMapLinkNode = record
    RSMapID       : Integer;
    RSMapX        : Integer;
    RSMapY        : Integer;
    RDMapID       : Integer;
    RDMapX        : Integer;
    RDMapY        : Integer;
    RVersion      : Integer;
  end;

  PXMLMapQuestNode = ^TXMLMapQuestNode;
  TXMLMapQuestNode = record
    RMapID        : Integer;
    RQFlag        : Integer;
    RState        : Integer;
    RSituation    : String;
    RMonID        : Integer;
    RItemID       : Integer;
    RQFileName    : String;
    RHeader       : String;
    RGroup        : Boolean;
    RVersion      : Integer;
  end;

  PXMLMethodeListNode = ^TXMLMethodeListNode;
  TXMLMethodeListNode = record
    RItemID       : Integer;
    RDesc         : String;
    RMethodeNo    : Integer;
    RMItem1_ID    : Integer;
    RNeedCount_1  : Integer;
    RMItem2_ID    : Integer;
    RNeedCount_2  : Integer;
    RMItem3_ID    : Integer;
    RNeedCount_3  : Integer;
    RMItem4_ID    : Integer;
    RNeedCount_4  : Integer;
    RMItem5_ID    : Integer;
    RNeedCount_5  : Integer;
    RMItem6_ID    : Integer;
    RNeedCount_6  : Integer;
  end;

  PXMLMNpcNode = ^TXMLMNpcNode;
  TXMLMNpcNode = record
    RNpcID        : Integer;
    RName         : String;
    RRole         : Integer;
    RFace         : Integer;
    RBody         : Integer;
    RVersion      : Integer;
  end;

  PXMLMNpcStandNode = ^TXMLMNpcStandNode;
  TXMLMNpcStandNode = record
    RNpcID        : Integer;
    RName         : String;
    RRole         : String;
    RLink         : String;
    RMapId        : Integer;
    RMapX         : Integer;
    RMapY         : Integer;
    RVersion      : Integer;
  end;

  PXMLMonAINode = ^TXMLMonAINode;
  TXMLMonAINode = record
    RMonID        : Integer;
    RMonAIFile    : String;
  end;

  PXMLMonClassNode = ^TXMLMonClassNode;
  TXMLMonClassNode = record
    RMonClassID   : Integer;
    RGrade        : String;
    RHP           : Integer;
    RHPMax        : Integer;
    RAC           : Integer;
    RACMax        : Integer;
    RMAC          : Integer;
    RDC_DP        : Integer;
    RMC_Type      : Integer;
    RMC_DP        : Integer;
    RDOT_D        : Integer;
    RSpeed        : Integer;
    RHit          : Integer;
    RWalkSpeed    : Integer;
    RAttackSpeed  : Integer;
    RAddExp       : Integer;
    RAddExpMax    : Integer;
  end;

  PXMLMonItemsNode = ^TXMLMonItemsNode;
  TXMLMonItemsNode = record
    RMonID        : Integer;
    RStartLevel   : Integer;
    REndLevel     : Integer;
    RPercent      : Integer;
    RItemID       : Integer;
    RAmount       : Integer;
    RGrouping     : Boolean;
    RDropSet      : Boolean;
    RZoneLevel    : String;
    RVersion      : Integer;
  end;

  PXMLMonsterNode = ^TXMLMonsterNode;
  TXMLMonsterNode = record
    RMonID        : Integer;
    RUsed         : Boolean;
    RName         : String;
    RRace         : Integer;
    RRaceImg      : Integer;
    RAppr         : Integer;
    RLevel        : Integer;
    RAntiFire     : Boolean;
    RUndead       : Boolean;
    RTameble      : Boolean;
    RCoolEye      : Integer;
    RViewRange    : Integer;
    RExp          : Integer;
    RHP           : Integer;
    RMP           : Integer;
    RDefaultAC    : Integer;
    RAC           : Integer;
    RDefaultMac   : Integer;
    RMac_Fire     : Integer;
    RMac_Ice      : Integer;
    RMac_Light    : Integer;
    RMac_Wind     : Integer;
    RMac_Holy     : Integer;
    RMac_Dark     : Integer;
    RMac_Phantom  : Integer;
    RDCMin        : Integer;
    RDCMax        : Integer;
    RMC_Type      : Integer;
    RMCMin        : Integer;
    RMCMax        : Integer;
    RMagLevel     : Integer;
    RSpeed        : Integer;
    RHit          : Integer;
    RWalkSpeed    : Integer;
    RWalkStep     : Integer;
    RWalkWait     : Integer;
    RAttackSpeed  : Integer;
    RZoneLevel    : String;
    RKoreaName    : String;
    RMoveable     : Boolean;
    RMonserGradeID: Integer;
  end;

  PXMLPetNode = ^TXMLPetNode;
  TXMLPetNode = record
    RPetID        : Integer;
    RMonID        : Integer;
    RAppr         : Integer;
    RPrice        : Int64;
    RName         : String;
    RDescription  : String;
  end;

  PXMLPetExpNode = ^TXMLPetExpNode;
  TXMLPetExpNode = record
    RPetLevel     : Integer;
    RNeedExp      : Integer;
    RMaxStatis    : Integer;
    RDimiStatis   : Integer;
  end;

  PXMLPetSkillNode = ^TXMLPetSkillNode;
  TXMLPetSkillNode = record
    RPetSkillID   : Integer;
    RSkillName    : String;
    RMaxValue     : Integer;
    RGetLevel     : Integer;
    RGetPer       : Integer;
    RKoreaName    : String;
  end;

  PXMLProItemsNode = ^TXMLProItemsNode;
  TXMLProItemsNode = record
    RItemID       : Integer;
    RDescription  : String;
    RItemType     : Integer;
    RSortNo       : Integer;
    RRare         : Integer;
    RCount        : Integer;
    RReqAP        : Integer;
    RSuccessRate  : Single;
    RGetAExp      : Integer;
    RUseTime      : Integer;
  end;

  PXMLQItemDropNode = ^TXMLQItemDropNode;
  TXMLQItemDropNode = record
    RQuestID      : Integer;
    RMonID        : Integer;
    RQuestItemID  : Integer;
    RRate         : Single;
  end;

  PXMLQuestNode = ^TXMLQuestNode;
  TXMLQuestNode = record
    RQuestID      : Integer;
    RStoryCode    : Integer;
    RQuestTitle   : String;
    RQuestKind    : Integer;
    RCR_Level     : Integer;
    RMapID        : Integer;
    ROpenNpcID    : Integer;
    RCompNpcID    : Integer;
    RTimeLimit    : Integer;
    RPrevQuestID  : Integer;
    RREQ_LV       : Integer;
    RReqGender    : Integer;
    RReqFame      : Integer;
    RReqJob       : Integer;
    RReqPKPoints  : Integer;
    RReqCP        : Integer;
    RNrExp        : Integer;
    RNrFame       : Integer;
    RNrGold       : Integer;
    RNrPKPDecrease: Integer;
    RNrCP         : Integer;
    ROpenSentence : String;
    RCompSentence : String;
    RClearSentence: String;
    RApplyRow     : Integer;
  end;

  PXMLQuestCompNode = ^TXMLQuestCompNode;
  TXMLQuestCompNode = record
    RQuestID      : Integer;
    RQuestMark    : Integer;
    RMarkID       : Integer;
    RCount        : Integer;
  end;

  PXMLQuestItemNode = ^TXMLQuestItemNode;
  TXMLQuestItemNode = record
    RQuestID      : Integer;
    RQuestItemName: String;
  end;

  PXMLQuestReactionNode = ^TXMLQuestReactionNode;
  TXMLQuestReactionNode = record
    RQuestID        : Integer;
    RReactionNum    : Integer;
    RReactionType   : Integer;
    RMoveMapNum     : String;
    RMoveMapX       : Integer;
    RMoveMapY       : Integer;
    RSummonID       : Integer;
    RSummonAmount   : Integer;
    RSummonStayTime : Integer;
    RSummonRadius   : Integer;
  end;

  PXMLQuestRewardNode = ^TXMLQuestRewardNode;
  TXMLQuestRewardNode = record
    RQuestID        : Integer;
    RRewardType     : Integer;
    RItemID         : Integer;
    RCount          : Integer;
  end;

  PXMLRandomBoxNode = ^TXMLRandomBoxNode;
  TXMLRandomBoxNode = record
    RUseItemID      : Integer;
    RNeedJob        : Integer;
    RNeedMinLevel   : Integer;
    RNeedMaxLevel   : Integer;
    RNeedItem_1     : Integer;
    RNeedItem_2     : Integer;
    RNeedItem_3     : Integer;
    RPercent        : Single;
    RRewardItemID   : Integer;
    RRewardUseTime  : Integer;
    RRewardAmount   : Integer;
  end;

  PXMLRareItemsNode = ^TXMLRareItemsNode;
  TXMLRareItemsNode = record
    RItemID         : Integer;
    RUPGProb        : Integer;
    RDropHour       : Integer;
  end;

  PXMLStartPointNode = ^TXMLStartPointNode;
  TXMLStartPointNode = record
    RMapID          : Integer;
    RMapX           : Integer;
    RMapY           : Integer;
    RVersion        : Integer;
  end;

  PXMLStdItemsNode = ^TXMLStdItemsNode;
  TXMLStdItemsNode = record
    RItemID            : Integer;
    RItemName          : String;
    RStdMode           : Integer;
    RShape             : Integer;
    RWeight            : Integer;
    RCharLooks         : Integer;
    RAniCount          : Integer;
    RSource            : Integer;
    RReserved          : Integer;
    RExpiring          : Integer;
    RNeedFame          : Integer;
    RThrow             : Integer;
    RLooks             : Integer;
    RDuraMax           : Integer;
    RAC                : Integer;
    RAC2               : Integer;
    RMacType           : Integer;
    RMac               : Integer;
    RMac2              : Integer;
    RAAtomGood         : Integer;
    RAAtomBad          : Integer;
    RDCMin             : Integer;
    RDCMax             : Integer;
    RMcType            : Integer;
    RMCMin             : Integer;
    RMCMax             : Integer;
    RWAtom             : Boolean;
    RWAtomValue        : Integer;
    RFuncType          : Integer;
    RNeed              : Integer;
    RNeedLevel         : Integer;
    RNeedJob           : Integer;
    RPrice             : Int64;
    RStock             : Integer;
    RKoreaName         : String;
    RAccur             : Integer;
    RATSpeed           : Integer;
    RSPSpeed           : Integer;
    RAgility           : Integer;
    RMagiceVade        : Integer;
    RComfort           : Integer;
    REquipWeight       : Integer;
    RHandleWeight      : Integer;
    RBagWeight         : Integer;
    RHP                : Integer;
    RMP                : Integer;
    RDetail            : String;
    RRedc              : Integer;
    RMagicCate         : Integer;  //Bool?
    RReMagic           : Integer;
    RTransLevel        : Integer;
    RUndetachable      : Boolean;
    RBelonging         : Integer; // Bool?
    RSetNo             : Integer;
    RSetIndex          : Int64;
    RDieOut            : Boolean;
    RDropOut           : Boolean;
    RGuildOwner        : Boolean; // Bool?? ID can by 0:None /1:Sabuk / 2:Taosung
    RInternetCafe      : Boolean; // Bool??
    RGroup             : Boolean; // Bool??
    RMaxQuality        : Integer;
    RRefine            : Boolean; // Bool??
    RDrop              : Boolean; // Bool??
    RLucky             : Integer;
    RDestruction       : Boolean; // Bool??
    RScale             : Integer;
    REffectID          : Integer;
    RRatioType         : Integer;
    RRatio             : Integer;
    RRepairable        : Boolean; //can by Normal Repair
    RSRepairable       : Boolean; //can by Special Repair
    RMarriage          : Boolean; //can by used for Marriage
    RResurrectionRatio : Integer;
    RSuccessRatio      : Integer;
    RMethodRare        : Integer;
    RTaoistSkillRatio  : Integer;
    RTradeUser         : Boolean; // Bool??
    RTradeShop         : Boolean; // Bool??
    RTradeEntrust      : Boolean; // Bool??
  end;

  PXMLStringSNode = ^TXMLStringSNode;
  TXMLStringSNode = record
    RStringID       : Integer;
    RText           : String;
    RType           : String;
  end;

  PXMLUNpcNode = ^TXMLUNpcNode;
  TXMLUNpcNode = record
    RNpcID          : Integer;
    RName           : String;
    RRole           : String;
    RLink           : String;
    RMapID          : Integer;
    RMapX           : Integer;
    RMapY           : Integer;
    RFace           : Integer;
    RBody           : Integer;
    RVersion        : Integer;
    RApplyRow       : Integer;
  end;

  PXMLMonGenNode = ^TXMLMonGenNode;
  TXMLMonGenNode = record
    RMapID          : Integer;
    RMapX           : Integer;
    RMapY           : Integer;
    RMonID          : Integer;
    RMonClassID     : Integer;
    RDropSet        : Boolean;
    RRange          : Integer;
    RAmount         : Integer;
    RGenTime        : Integer;
    RConPercent     : Integer;
    RZoneLevel      : String;
    RVersion        : Integer;
  end;

  PXMLSaleItemsNode = ^TXMLSaleItemsNode;
  TXMLSaleItemsNode = record
    RTemp           : String;
    RIdentifer      : String;
    RCategory       : Integer;
    RHeader         : Integer;
    RName           : String;
    RIndex          : Int64;
    RDura           : Integer;
    RDuraMax        : Integer;
    RDesc0          : Integer;
    RDesc1          : Integer;
    RDesc2          : Integer;
    RDesc3          : Integer;
    RDesc4          : Integer;
    RDesc5          : Integer;
    RDesc6          : Integer;
    RDesc7          : Integer;
    RDesc8          : Integer;
    RDesc9          : Integer;
    RDesc10         : Integer;
    RDesc11         : Integer;
    RDesc12         : Integer;
    RDesc13         : Integer;
    RColor_R        : Byte;
    RColor_G        : Byte;
    RColor_B        : Byte;
    RQuality        : Integer;
    RPermitPeriode  : Integer;
    RSalePrice      : Int64;
    RKoreaName      : String;
    RSaleStartDate  : String;
    RSaleEndTime    : String;
    RNoSell         : Boolean;
    RDetail         : String;
    RBuffImage      : Integer;
  end;

  PXMLAdminListNode = ^TXMLAdminListNode;
  TXMLAdminListNode = record
    RAdminID        : Integer;
    RDBUserID       : String;
    RAdminRole      : String;
    RRoleLevel      : Integer;
  end;

  PXMLResourceReader = ^TXMLResourceReader;
  TXMLResourceReader = class
  private
    FXMLDomDoc  : IXMLDocument;
    FXMLDomNode : IDOMNode;
  private
    FArtisanLevelDataList   : TList<TXMLArtisanLevelNode>;
    FEtcSrciptDataList      : TList<TXMLEtcSrciptNode>;
    FGuardListDataList      : TList<TXMLGuardListNode>;
    FMagicDataList          : TList<TXMLMagicNode>;
    FMapInfoDataList        : TList<TXMLMapInfoNode>;
    FMapLinkDataList        : TList<TXMLMapLinkNode>;
    FMapQuestDataList       : TList<TXMLMapQuestNode>;
    FMethodeListDataList    : TList<TXMLMethodeListNode>;
    FMNpcDataList           : TList<TXMLMNpcNode>;
    FMNpcStandDataList      : TList<TXMLMNpcStandNode>;
    FMonAIDataList          : TList<TXMLMonAINode>;
    FMonClassDataList       : TList<TXMLMonClassNode>;
    FMonItemsDataList       : TList<TXMLMonItemsNode>;
    FMonsterDataList        : TList<TXMLMonsterNode>;
    FPetDataList            : TList<TXMLPetNode>;
    FPetExpDataList         : TList<TXMLPetExpNode>;
    FPetSkillDataList       : TList<TXMLPetSkillNode>;
    FProItemsDataList       : TList<TXMLProItemsNode>;
    FQItemDropDataList      : TList<TXMLQItemDropNode>;
    FQuestDataList          : TList<TXMLQuestNode>;
    FQuestCompDataList      : TList<TXMLQuestCompNode>;
    FQuestItemDataList      : TList<TXMLQuestItemNode>;
    FQuestReactionDataList  : TList<TXMLQuestReactionNode>;
    FQuestRewardDataList    : TList<TXMLQuestRewardNode>;
    FRandomBoxDataList      : TList<TXMLRandomBoxNode>;
    FRareItemsDataList      : TList<TXMLRareItemsNode>;
    FStartPointDataList     : TList<TXMLStartPointNode>;
    FStdItemsDataList       : TList<TXMLStdItemsNode>;
    FStringSDataList        : TList<TXMLStringSNode>;
    FUNpcDataList           : TList<TXMLUNpcNode>;
    FMonGenDataList         : TList<TXMLMonGenNode>;
    FSaleItemsDataList      : TList<TXMLSaleItemsNode>;
    FAdminListDataList      : TList<TXMLAdminListNode>;
    FCountArtisanLevelNodes : Integer;
    FCountEtcScriptNodes    : Integer;
    FCountGuardListNodes    : Integer;
    FCountMagicNodes        : Integer;
    FCountMapInfoNodes      : Integer;
    FCountMapLinkNodes      : Integer;
    FCountMapQuestNodes     : Integer;
    FCountMethodeListNodes  : Integer;
    FCountMNpcNodes         : Integer;
    FCountMNpcStandNodes    : Integer;
    FCountMonAINodes        : Integer;
    FCountMonClassNodes     : Integer;
    FCountMonItemsNodes     : Integer;
    FCountMonsterNodes      : Integer;
    FCountPetNodes          : Integer;
    FCountPetExpNodes       : Integer;
    FCountPetSkillNodes     : Integer;
    FCountProItemsNodes     : Integer;
    FCountQItemDropNodes    : Integer;
    FCountQuestNodes        : Integer;
    FCountQuestCompNodes    : Integer;
    FCountQuestItemNodes    : Integer;
    FCountQuestReactionNodes: Integer;
    FCountQuestRewardNodes  : Integer;
    FCountRandomBoxNodes    : Integer;
    FCountRareItemsNodes    : Integer;
    FCountStartPointNodes   : Integer;
    FCountStdItemsNodes     : Integer;
    FCountStringSNodes      : Integer;
    FCountUNpcNodes         : Integer;
    FCountMonGenNodes       : Integer;
    FCountSaleItemsNodes    : Integer;
    FCountAdminListNodes    : Integer;
  public
    constructor Create;
    destructor Destroy; override;
  public
    function ReadXMLResource(AFileName: String): Boolean;
    procedure FullXMLListReload;
  public
    {$REGION ' - TXMLResourceReader Load Functions '}
    procedure LoadArtisanLevel; overload;
    procedure LoadArtisanLevel(var ADataList: TList<TXMLArtisanLevelNode>); overload;
    procedure LoadEtcScript; overload;
    procedure LoadEtcScript(var ADataList: TList<TXMLEtcSrciptNode>); overload;
    procedure LoadGuardList; overload;
    procedure LoadGuardList(var ADataList: TList<TXMLGuardListNode>); overload;
    procedure LoadMagic; overload;
    procedure LoadMagic(var ADataList: TList<TXMLMagicNode>); overload;
    procedure LoadMapInfo; overload;
    procedure LoadMapInfo(var ADataList: TList<TXMLMapInfoNode>); overload;
    procedure LoadMapLink; overload;
    procedure LoadMapLink(var ADataList: TList<TXMLMapLinkNode>); overload;
    procedure LoadMapQuest; overload;
    procedure LoadMapQuest(var ADataList: TList<TXMLMapQuestNode>); overload;
    procedure LoadMethodeList; overload;
    procedure LoadMethodeList(var ADataList: TList<TXMLMethodeListNode>); overload;
    procedure LoadMNpc; overload;
    procedure LoadMNpc(var ADataList: TList<TXMLMNpcNode>); overload;
    procedure LoadMNpcStand; overload;
    procedure LoadMNpcStand(var ADataList: TList<TXMLMNpcStandNode>); overload;
    procedure LoadMonAI; overload;
    procedure LoadMonAI(var ADataList: TList<TXMLMonAINode>); overload;
    procedure LoadMonClass; overload;
    procedure LoadMonClass(var ADataList: TList<TXMLMonClassNode>); overload;
    procedure LoadMonItems; overload;
    procedure LoadMonItems(var ADataList: TList<TXMLMonItemsNode>); overload;
    procedure LoadMonster; overload;
    procedure LoadMonster(var ADataList: TList<TXMLMonsterNode>); overload;
    procedure LoadPet; overload;
    procedure LoadPet(var ADataList: TList<TXMLPetNode>); overload;
    procedure LoadPetExp; overload;
    procedure LoadPetExp(var ADataList: TList<TXMLPetExpNode>); overload;
    procedure LoadPetSkill; overload;
    procedure LoadPetSkill(var ADataList: TList<TXMLPetSkillNode>); overload;
    procedure LoadProItems; overload;
    procedure LoadProItems(var ADataList: TList<TXMLProItemsNode>); overload;
    procedure LoadQItemDrop; overload;
    procedure LoadQItemDrop(var ADataList: TList<TXMLQItemDropNode>); overload;
    procedure LoadQuest; overload;
    procedure LoadQuest(var ADataList: TList<TXMLQuestNode>); overload;
    procedure LoadQuestComp; overload;
    procedure LoadQuestComp(var ADataList: TList<TXMLQuestCompNode>); overload;
    procedure LoadQuestItem; overload;
    procedure LoadQuestItem(var ADataList: TList<TXMLQuestItemNode>); overload;
    procedure LoadQuestReaction; overload;
    procedure LoadQuestReaction(var ADataList: TList<TXMLQuestReactionNode>); overload;
    procedure LoadQuestReward; overload;
    procedure LoadQuestReward(var ADataList: TList<TXMLQuestRewardNode>); overload;
    procedure LoadRandomBox; overload;
    procedure LoadRandomBox(var ADataList: TList<TXMLRandomBoxNode>); overload;
    procedure LoadRareItems; overload;
    procedure LoadRareItems(var ADataList: TList<TXMLRareItemsNode>); overload;
    procedure LoadStartPoint; overload;
    procedure LoadStartPoint(var ADataList: TList<TXMLStartPointNode>); overload;
    procedure LoadStdItems; overload;
    procedure LoadStdItems(var ADataList: TList<TXMLStdItemsNode>); overload;
    procedure LoadStringS; overload;
    procedure LoadStringS(var ADataList: TList<TXMLStringSNode>); overload;
    procedure LoadUNpc; overload;
    procedure LoadUNpc(var ADataList: TList<TXMLUNpcNode>); overload;
    procedure LoadMonGen; overload;
    procedure LoadMonGen(var ADataList: TList<TXMLMonGenNode>); overload;
    procedure LoadSaleItems; overload;
    procedure LoadSaleItems(var ADataList: TList<TXMLSaleItemsNode>); overload;
    procedure LoadAdminList; overload;
    procedure LoadAdminList(var ADataList: TList<TXMLAdminListNode>); overload;
    function GetMonsterNameByID(const AIndex: Integer): String;
    function GetStdItemNameByID(const AIndex: Integer): String;
    function GetMapNameByID(const AIndex: Integer): String;
    {$ENDREGION}
  public
    {$REGION ' - TXMLResourceReader List Propertys '}
    property ArtisanLevelDataList : TList<TXMLArtisanLevelNode>  read FArtisanLevelDataList;
    property EtcSrciptDataList    : TList<TXMLEtcSrciptNode>     read FEtcSrciptDataList;
    property GuardListDataList    : TList<TXMLGuardListNode>     read FGuardListDataList;
    property MagicDataList        : TList<TXMLMagicNode>         read FMagicDataList;
    property MapInfoDataList      : TList<TXMLMapInfoNode>       read FMapInfoDataList;
    property MapLinkDataList      : TList<TXMLMapLinkNode>       read FMapLinkDataList;
    property MapQuestDataList     : TList<TXMLMapQuestNode>      read FMapQuestDataList;
    property MethodeListDataList  : TList<TXMLMethodeListNode>   read FMethodeListDataList;
    property MNpcDataList         : TList<TXMLMNpcNode>          read FMNpcDataList;
    property MNpcStandDataList    : TList<TXMLMNpcStandNode>     read FMNpcStandDataList;
    property MonAIDataList        : TList<TXMLMonAINode>         read FMonAIDataList;
    property MonClassDataList     : TList<TXMLMonClassNode>      read FMonClassDataList;
    property MonItemsDataList     : TList<TXMLMonItemsNode>      read FMonItemsDataList;
    property MonsterDataList      : TList<TXMLMonsterNode>       read FMonsterDataList;
    property PetDataList          : TList<TXMLPetNode>           read FPetDataList;
    property PetExpDataList       : TList<TXMLPetExpNode>        read FPetExpDataList;
    property PetSkillDataList     : TList<TXMLPetSkillNode>      read FPetSkillDataList;
    property ProItemsDataList     : TList<TXMLProItemsNode>      read FProItemsDataList;
    property QItemDropDataList    : TList<TXMLQItemDropNode>     read FQItemDropDataList;
    property QuestDataList        : TList<TXMLQuestNode>         read FQuestDataList;
    property QuestCompDataList    : TList<TXMLQuestCompNode>     read FQuestCompDataList;
    property QuestItemDataList    : TList<TXMLQuestItemNode>     read FQuestItemDataList;
    property QuestReactionDataList: TList<TXMLQuestReactionNode> read FQuestReactionDataList;
    property QuestRewardDataList  : TList<TXMLQuestRewardNode>   read FQuestRewardDataList;
    property RandomBoxDataList    : TList<TXMLRandomBoxNode>     read FRandomBoxDataList;
    property RareItemsDataList    : TList<TXMLRareItemsNode>     read FRareItemsDataList;
    property StartPointDataList   : TList<TXMLStartPointNode>    read FStartPointDataList;
    property StdItemsDataList     : TList<TXMLStdItemsNode>      read FStdItemsDataList;
    property StringSDataList      : TList<TXMLStringSNode>       read FStringSDataList;
    property UNpcDataList         : TList<TXMLUNpcNode>          read FUNpcDataList;
    property MonGenDataList       : TList<TXMLMonGenNode>        read FMonGenDataList;
    property SaleItemsDataList    : TList<TXMLSaleItemsNode>     read FSaleItemsDataList;
    property AdminListDataList    : TList<TXMLAdminListNode>     read FAdminListDataList;
    {$ENDREGION}
    {$REGION ' - TXMLResourceReader List Counter Propertys '}
    property CountArtisanLevelNodes : Integer read FCountArtisanLevelNodes;
    property CountEtcScriptNodes    : Integer read FCountEtcScriptNodes;
    property CountGuardListNodes    : Integer read FCountGuardListNodes;
    property CountMagicNodes        : Integer read FCountMagicNodes;
    property CountMapInfoNodes      : Integer read FCountMapInfoNodes;
    property CountMapLinkNodes      : Integer read FCountMapLinkNodes;
    property CountMapQuestNodes     : Integer read FCountMapQuestNodes;
    property CountMethodeListNodes  : Integer read FCountMethodeListNodes;
    property CountMNpcNodes         : Integer read FCountMNpcNodes;
    property CountMNpcStandNodes    : Integer read FCountMNpcStandNodes;
    property CountMonAINodes        : Integer read FCountMonAINodes;
    property CountMonClassNodes     : Integer read FCountMonClassNodes;
    property CountMonItemsNodes     : Integer read FCountMonItemsNodes;
    property CountMonsterNodes      : Integer read FCountMonsterNodes;
    property CountPetNodes          : Integer read FCountPetNodes;
    property CountPetExpNodes       : Integer read FCountPetExpNodes;
    property CountPetSkillNodes     : Integer read FCountPetSkillNodes;
    property CountProItemsNodes     : Integer read FCountProItemsNodes;
    property CountQItemDropNodes    : Integer read FCountQItemDropNodes;
    property CountQuestNodes        : Integer read FCountQuestNodes;
    property CountQuestCompNodes    : Integer read FCountQuestCompNodes;
    property CountQuestItemNodes    : Integer read FCountQuestItemNodes;
    property CountQuestReactionNodes: Integer read FCountQuestReactionNodes;
    property CountQuestRewardNodes  : Integer read FCountQuestRewardNodes;
    property CountRandomBoxNodes    : Integer read FCountRandomBoxNodes;
    property CountRareItemsNodes    : Integer read FCountRareItemsNodes;
    property CountStartPointNodes   : Integer read FCountStartPointNodes;
    property CountStdItemsNodes     : Integer read FCountStdItemsNodes;
    property CountStringSNodes      : Integer read FCountStringSNodes;
    property CountUNpcNodes         : Integer read FCountUNpcNodes;
    property CountMonGenNodes       : Integer read FCountMonGenNodes;
    property CountSaleItemsNodes    : Integer read FCountSaleItemsNodes;
    property CountAdminListNodes    : Integer read FCountAdminListNodes;
    {$ENDREGION}
  end;

var
  GXMLResourceReader : TXMLResourceReader;

implementation

uses Mir3FormsMainSystem;

  (* class TXMLResourceReader *)

{$REGION ' - TXMLResourceReader Constructor / Destructor '}
  constructor TXMLResourceReader.Create;
  begin
    FXMLDomDoc  := nil;
    FXMLDomNode := nil;

    FArtisanLevelDataList   := TList<TXMLArtisanLevelNode>.Create;
    FEtcSrciptDataList      := TList<TXMLEtcSrciptNode>.Create;
    FGuardListDataList      := TList<TXMLGuardListNode>.Create;
    FMagicDataList          := TList<TXMLMagicNode>.Create;
    FMapInfoDataList        := TList<TXMLMapInfoNode>.Create;
    FMapLinkDataList        := TList<TXMLMapLinkNode>.Create;
    FMapQuestDataList       := TList<TXMLMapQuestNode>.Create;
    FMethodeListDataList    := TList<TXMLMethodeListNode>.Create;
    FMNpcDataList           := TList<TXMLMNpcNode>.Create;
    FMNpcStandDataList      := TList<TXMLMNpcStandNode>.Create;
    FMonAIDataList          := TList<TXMLMonAINode>.Create;
    FMonClassDataList       := TList<TXMLMonClassNode>.Create;
    FMonItemsDataList       := TList<TXMLMonItemsNode>.Create;
    FMonsterDataList        := TList<TXMLMonsterNode>.Create;
    FPetDataList            := TList<TXMLPetNode>.Create;
    FPetExpDataList         := TList<TXMLPetExpNode>.Create;
    FPetSkillDataList       := TList<TXMLPetSkillNode>.Create;
    FProItemsDataList       := TList<TXMLProItemsNode>.Create;
    FQItemDropDataList      := TList<TXMLQItemDropNode>.Create;
    FQuestDataList          := TList<TXMLQuestNode>.Create;
    FQuestCompDataList      := TList<TXMLQuestCompNode>.Create;
    FQuestItemDataList      := TList<TXMLQuestItemNode>.Create;
    FQuestReactionDataList  := TList<TXMLQuestReactionNode>.Create;
    FQuestRewardDataList    := TList<TXMLQuestRewardNode>.Create;
    FRandomBoxDataList      := TList<TXMLRandomBoxNode>.Create;
    FRareItemsDataList      := TList<TXMLRareItemsNode>.Create;
    FStartPointDataList     := TList<TXMLStartPointNode>.Create;
    FStdItemsDataList       := TList<TXMLStdItemsNode>.Create;
    FStringSDataList        := TList<TXMLStringSNode>.Create;
    FUNpcDataList           := TList<TXMLUNpcNode>.Create;
    FMonGenDataList         := TList<TXMLMonGenNode>.Create;
    FSaleItemsDataList      := TList<TXMLSaleItemsNode>.Create;
    FAdminListDataList      := TList<TXMLAdminListNode>.Create;
  end;

  destructor TXMLResourceReader.Destroy;
  begin
    FArtisanLevelDataList.Clear;
    FEtcSrciptDataList.Clear;
    FGuardListDataList.Clear;
    FMagicDataList.Clear;
    FMapInfoDataList.Clear;
    FMapLinkDataList.Clear;
    FMapQuestDataList.Clear;
    FMethodeListDataList.Clear;
    FMNpcDataList.Clear;
    FMNpcStandDataList.Clear;
    FMonAIDataList.Clear;
    FMonClassDataList.Clear;
    FMonItemsDataList.Clear;
    FMonsterDataList.Clear;
    FPetDataList.Clear;
    FPetExpDataList.Clear;
    FPetSkillDataList.Clear;
    FProItemsDataList.Clear;
    FQItemDropDataList.Clear;
    FQuestDataList.Clear;
    FQuestCompDataList.Clear;
    FQuestItemDataList.Clear;
    FQuestReactionDataList.Clear;
    FQuestRewardDataList.Clear;
    FRandomBoxDataList.Clear;
    FRareItemsDataList.Clear;
    FStartPointDataList.Clear;
    FStdItemsDataList.Clear;
    FStringSDataList.Clear;
    FUNpcDataList.Clear;
    FMonGenDataList.Clear;
    FSaleItemsDataList.Clear;
    FAdminListDataList.Clear;
    (* Free and Nil *)
    FreeAndNil(FArtisanLevelDataList);
    FreeAndNil(FEtcSrciptDataList);
    FreeAndNil(FGuardListDataList);
    FreeAndNil(FMagicDataList);
    FreeAndNil(FMapInfoDataList);
    FreeAndNil(FMapLinkDataList);
    FreeAndNil(FMapQuestDataList);
    FreeAndNil(FMethodeListDataList);
    FreeAndNil(FMNpcDataList);
    FreeAndNil(FMNpcStandDataList);
    FreeAndNil(FMonAIDataList);
    FreeAndNil(FMonClassDataList);
    FreeAndNil(FMonItemsDataList);
    FreeAndNil(FMonsterDataList);
    FreeAndNil(FPetDataList);
    FreeAndNil(FPetExpDataList);
    FreeAndNil(FPetSkillDataList);
    FreeAndNil(FProItemsDataList);
    FreeAndNil(FQItemDropDataList);
    FreeAndNil(FQuestDataList);
    FreeAndNil(FQuestCompDataList);
    FreeAndNil(FQuestItemDataList);
    FreeAndNil(FQuestReactionDataList);
    FreeAndNil(FQuestRewardDataList);
    FreeAndNil(FRandomBoxDataList);
    FreeAndNil(FRareItemsDataList);
    FreeAndNil(FStartPointDataList);
    FreeAndNil(FStdItemsDataList);
    FreeAndNil(FStringSDataList);
    FreeAndNil(FUNpcDataList);
    FreeAndNil(FMonGenDataList);
    FreeAndNil(FSaleItemsDataList);
    FreeAndNil(FAdminListDataList);
    inherited Destroy;
  end;
{$ENDREGION}

{$REGION ' - TXMLResourceReader Public Function '}

  function TXMLResourceReader.ReadXMLResource(AFileName: String): Boolean;
  var
    FStream : TFileStream;
  begin
    Result := True;
    try
      if not FileExists(AFilename) then
        raise Exception.Create('file does not exist: ' + aFilename);
      FStream := TFileStream.Create(aFilename, fmOpenRead);

      if FileExists(AFileName) then
      begin
        FXMLDomDoc       := TXMLDocument.Create(nil);
        FXMLDomDoc.LoadFromStream(FStream);

        if FXMLDomDoc = nil then
          raise Exception.Create('[Exception] - XML Load error...');
      end else exit;
    except
      Result := False;
    end;
  end;

  procedure TXMLResourceReader.FullXMLListReload;
  begin
    // TODO: Reload Option (User can say only this or this...)
    LoadArtisanLevel;
    LoadEtcScript;
    LoadGuardList;
    LoadMagic;
    LoadMapInfo;
    LoadMapLink;
    LoadMapQuest;
    LoadMethodeList;
    LoadMNpc;
    LoadMNpcStand;
    LoadMonAI;
    LoadMonClass;
    LoadMonItems;
    LoadMonster;
    LoadPet;
    LoadPetExp;
    LoadPetSkill;
    LoadProItems;
    LoadQItemDrop;
    LoadQuest;
    LoadQuestComp;
    LoadQuestItem;
    LoadQuestReaction;
    LoadQuestReward;
    LoadRandomBox;
    LoadRareItems;
    LoadStartPoint;
    LoadStdItems;
    LoadStringS;
    LoadUNpc;
    LoadMonGen;
    LoadSaleItems;
    LoadAdminList;
  end;

    (* Load Functions *)

  procedure TXMLResourceReader.LoadArtisanLevel;
  begin
    LoadArtisanLevel(FArtisanLevelDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Artisan Level - (' + IntToStr(FCountArtisanLevelNodes)+')');
  end;

  procedure TXMLResourceReader.LoadArtisanLevel(var ADataList: TList<TXMLArtisanLevelNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLArtisanLevelNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ALV' then
            FNode.RArtisanLevel := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ACCU_AEXP' then
            FNode.RAccuEXP      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_AEXP' then
            FNode.RNeedEXP      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAX_AP' then
            FNode.RMax_AP       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_ARTISANLV' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountArtisanLevelNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadArtisanLevel');
    end;
  end;

  procedure TXMLResourceReader.LoadEtcScript;
  begin
    LoadEtcScript(FEtcSrciptDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Etc Srcipt - (' + IntToStr(FCountEtcScriptNodes)+')');
  end;

  procedure TXMLResourceReader.LoadEtcScript(var ADataList: TList<TXMLEtcSrciptNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLEtcSrciptNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ETC_ID' then
            FNode.REtcID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'KORNAME' then
            FNode.RKoreaName := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_ETCSCRIPT' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountEtcScriptNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadEtcScript');
    end;
  end;

  procedure TXMLResourceReader.LoadGuardList;
  begin
    LoadGuardList(FGuardListDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Guard List - (' + IntToStr(FCountGuardListNodes)+')');
  end;

  procedure TXMLResourceReader.LoadGuardList(var ADataList: TList<TXMLGuardListNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLGuardListNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_X' then
            FNode.RMapX      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_Y' then
            FNode.RMapY      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DIR' then
            FNode.RDirection := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_GUARDLIST' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountGuardListNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadGuardList');
    end;
  end;

  procedure TXMLResourceReader.LoadMagic;
  begin
    LoadMagic(FMagicDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Magic List - (' + IntToStr(FCountMagicNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMagic(var ADataList: TList<TXMLMagicNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMagicNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MAGID' then
            FNode.RMagicID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAGNAME' then
            FNode.RMagicName    := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'TYPE' then
            FNode.RMagicType    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EFFECTTYPE' then
            FNode.REffectType   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EFFECT' then
            FNode.REffect       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SPELL' then
            FNode.RSpellID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'POWER' then
            FNode.RPower        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAXPOWER' then
            FNode.RMaxPower     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DEFSPELL' then
            FNode.RDefSpell     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DEFPOWER' then
            FNode.RDefPower     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DEFMAXPOWER' then
            FNode.RDefMaxPower  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'JOB' then
            FNode.RJobID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PHASE' then
            FNode.RPhase        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDL1' then
            FNode.RNeedLevel_1  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'L1TRAIN' then
            FNode.RTrainLevel_1 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDL2' then
            FNode.RNeedLevel_2  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'L2TRAIN' then
            FNode.RTrainLevel_2 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDL3' then
            FNode.RNeedLevel_3  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'L3TRAIN' then
            FNode.RTrainLevel_3 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDL4' then
            FNode.RNeedLevel_4  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'L4TRAIN' then
            FNode.RTrainLevel_4 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDL5' then
            FNode.RNeedLevel_5  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'L5TRAIN' then
            FNode.RTrainLevel_5 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DELAY' then
            FNode.RDelay        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COOLTIME' then
            FNode.RCoolTime     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'KORNAME' then
            FNode.RKoreaName    := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'SKILLTYPE' then
            FNode.RSkillType    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TOOLTIP' then
            FNode.RToolTip      := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MAGIC' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMagicNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMagic');
    end;
  end;

  procedure TXMLResourceReader.LoadMapInfo;
  begin
    LoadMapInfo(FMapInfoDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read MapInfo List - (' + IntToStr(FCountMapInfoNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMapInfo(var ADataList: TList<TXMLMapInfoNode>);

   procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMapInfoNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP' then
            FNode.RMapName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MAPNAME' then
            FNode.RMapTitle     := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'SERVER' then
            FNode.RServerID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'CHNSERVER' then
            FNode.RCHNServerID  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDLEVEL' then
            FNode.RNeedLevel    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TIME' then
            FNode.RTime         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WEATHER' then
            FNode.RWeather      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VEHICLE' then
            FNode.RVehicle      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PVP' then
            FNode.RPVP          := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'MINE' then
            FNode.RMine         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'CONTROL' then
            FNode.RControl      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ENTERLV' then
            FNode.REnterLevel   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ENTERQUEST' then
            FNode.REnterQuest   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ENTERITEM' then
            FNode.REnterItem    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NORECONNECT' then
            FNode.RNoReconnect  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MINIMAP' then
            FNode.RMiniMap      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'APPLY_ROW' then
            FNode.RApplyRow     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_EXP_RATIO' then
            FNode.RMapExpRatio  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_DROP_RATIO' then
            FNode.RMapDropRatio := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_MONEY_RATIO' then
            FNode.RMapMoneyRatio:= StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ORDERLIST' then
            FNode.ROrderList    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MAPINFO' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMapInfoNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMapInfo');
    end;
  end;

  procedure TXMLResourceReader.LoadMapLink;
  begin
    LoadMapLink(FMapLinkDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read MapLink List - (' + IntToStr(FCountMapLinkNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMapLink(var ADataList: TList<TXMLMapLinkNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMapLinkNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'SMAP_ID' then
            FNode.RSMapID    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SMAP_X' then
            FNode.RSMapX     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SMAP_Y' then
            FNode.RSMapY     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DMAP_ID' then
            FNode.RDMapID    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DMAP_X' then
            FNode.RDMapX     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DMAP_Y' then
            FNode.RDMapY     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'Ver' then
            FNode.RVersion   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MAPLINK' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMapLinkNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMapLink');
    end;
  end;

  procedure TXMLResourceReader.LoadMapQuest;
  begin
    LoadMapQuest(FMapQuestDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read MapQuest List - (' + IntToStr(FCountMapQuestNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMapQuest(var ADataList: TList<TXMLMapQuestNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMapQuestNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QFLAG' then
            FNode.RQFlag     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'STATE' then
            FNode.RState      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SITUATION' then
            FNode.RSituation  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QFILENAME' then
            FNode.RQFileName  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'HEADER' then
            FNode.RHeader     := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'GROUP' then
            FNode.RGroup      := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MAPQUEST' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMapQuestNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMapQuest');
    end;
  end;

  procedure TXMLResourceReader.LoadMethodeList;
  begin
    LoadMethodeList(FMethodeListDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Methode List - (' + IntToStr(FCountMethodeListNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMethodeList(var ADataList: TList<TXMLMethodeListNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMethodeListNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DESC' then
            FNode.RDesc        := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'METHOD_NO' then
            FNode.RMethodeNo   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM1_ID' then
            FNode.RMItem1_ID   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT1' then
            FNode.RNeedCount_1 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM2_ID' then
            FNode.RNeedCount_2 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT2' then
            FNode.RNeedCount_2 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM3_ID' then
            FNode.RNeedCount_3 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT3' then
            FNode.RNeedCount_3 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM4_ID' then
            FNode.RNeedCount_4 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT4' then
            FNode.RNeedCount_4 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM5_ID' then
            FNode.RNeedCount_5 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT5' then
            FNode.RNeedCount_5 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MITEM6_ID' then
            FNode.RNeedCount_6 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_COUNT6' then
            FNode.RNeedCount_6 := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_METHODLIST' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMethodeListNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMethodeList');
    end;
  end;

  procedure TXMLResourceReader.LoadMNpc;
  begin
    LoadMNpc(FMNpcDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read M-NPC List - (' + IntToStr(FCountMNpcNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMNpc(var ADataList: TList<TXMLMNpcNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMNpcNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'NPC_ID' then
            FNode.RNpcID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ROLE' then
            FNode.RRole      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FACE' then
            FNode.RFace      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'BODY' then
            FNode.RBody      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MNPC' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMNpcNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMNpc');
    end;
  end;

  procedure TXMLResourceReader.LoadMNpcStand;
  begin
    LoadMNpcStand(FMNpcStandDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read M-NPC-Stand List - (' + IntToStr(FCountMNpcStandNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMNpcStand(var ADataList: TList<TXMLMNpcStandNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMNpcStandNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'NPC_ID' then
            FNode.RNpcID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ROLE' then
            FNode.RRole      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'LINK' then
            FNode.RLink      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapId     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_X' then
            FNode.RMapX      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_Y' then
            FNode.RMapY      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MNPC_STAND' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMNpcStandNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMNpcStand');
    end;
  end;

  procedure TXMLResourceReader.LoadMonAI;
  begin
    LoadMonAI(FMonAIDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read MonAI List - (' + IntToStr(FCountMonAINodes)+')');
  end;

  procedure TXMLResourceReader.LoadMonAI(var ADataList: TList<TXMLMonAINode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMonAINode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MONAI_FILE' then
            FNode.RMonAIFile := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MONAI' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonAINodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMonAI');
    end;
  end;

  procedure TXMLResourceReader.LoadMonClass;
  begin
    LoadMonClass(FMonClassDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Monster Class List - (' + IntToStr(FCountMonClassNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMonClass(var ADataList: TList<TXMLMonClassNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMonClassNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MON_CLASS_ID' then
            FNode.RMonClassID  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'GRADE' then
            FNode.RGrade       := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'HP' then
            FNode.RHP          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HPP' then
            FNode.RHPMax       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AC' then
            FNode.RAC          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ACP' then
            FNode.RACMax       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC' then
            FNode.RMAC         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DC_DP' then
            FNode.RDC_DP       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_TYPE' then
            FNode.RMC_Type     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_DP' then
            FNode.RMC_DP       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DOT_D' then
            FNode.RDOT_D       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SPEED' then
            FNode.RSpeed       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HIT' then
            FNode.RHit         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WALK_SPD' then
            FNode.RWalkSpeed   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ATTACK_SPD' then
            FNode.RAttackSpeed := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ADD_EXP' then
            FNode.RAddExp      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ADD_EXPP' then
            FNode.RAddExpMax   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MONCLASS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonClassNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMonClass');
    end;
  end;

  procedure TXMLResourceReader.LoadMonItems;
  begin
    LoadMonItems(FMonItemsDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Monster Item List - (' + IntToStr(FCountMonItemsNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMonItems(var ADataList: TList<TXMLMonItemsNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMonItemsNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'START_LV' then
            FNode.RStartLevel := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'END_LV' then
            FNode.REndLevel   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PERCENT' then
            FNode.RPercent    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AMOUNT' then
            FNode.RAmount     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'GROUPING' then
            FNode.RGrouping   := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'DROPSET' then
            FNode.RDropSet    := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'ZONELEVEL' then
            FNode.RZoneLevel  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MONITEMS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonItemsNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMonItems');
    end;
  end;

  procedure TXMLResourceReader.LoadMonster;
  begin
    LoadMonster(FMonsterDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Monster List - (' + IntToStr(FCountMonsterNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMonster(var ADataList: TList<TXMLMonsterNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMonsterNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'USED' then
            FNode.RUsed          := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName          := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'RACE' then
            FNode.RRace          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RACEIMG' then
            FNode.RRaceImg       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'APPR' then
            FNode.RAppr          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'LVL' then
            FNode.RLevel         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ANTIFIRE' then
            FNode.RAntiFire      := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'UNDEAD' then
            FNode.RUndead        := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'TAMEBLE' then
            FNode.RTameble       := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'COOLEYE' then
            FNode.RCoolEye       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VIEW_RANGE' then
            FNode.RViewRange     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EXP' then
            FNode.RExp           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HP' then
            FNode.RHP            := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MP' then
            FNode.RMP            := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DEFULTAC' then
            FNode.RDefaultAC     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AC' then
            FNode.RAC            := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DEFULTMAC' then
            FNode.RDefaultMac    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_FIRE' then
            FNode.RMac_Fire      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_ICE' then
            FNode.RMac_Ice       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_LIGHT' then
            FNode.RMac_Light     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_WIND' then
            FNode.RMac_Wind      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_HOLY' then
            FNode.RMac_Holy      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_DARK' then
            FNode.RMac_Dark      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_PHANTOM' then
            FNode.RMac_Phantom   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DC_min' then
            FNode.RDCMin         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DC_max' then
            FNode.RDCMax         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_TYPE' then
            FNode.RMC_Type       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_min' then
            FNode.RMCMin         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_max' then
            FNode.RMCMax         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAG_LEVEL' then
            FNode.RMagLevel      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SPEED' then
            FNode.RSpeed         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HIT' then
            FNode.RHit           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WALK_SPD' then
            FNode.RWalkSpeed     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WALKSTEP' then
            FNode.RWalkStep      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WALKWAIT' then
            FNode.RWalkWait      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ATTACK_SPD' then
            FNode.RAttackSpeed   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ZONELEVEL' then
            FNode.RZoneLevel     := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'KORNAME' then
            FNode.RKoreaName     := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MOVE_ABLE' then
            FNode.RMoveable      := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'MONSTER_GRADE' then
            FNode.RMonserGradeID := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MONSTER' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonsterNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMonster');
    end;
  end;

  procedure TXMLResourceReader.LoadPet;
  begin
    LoadPet(FPetDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Pet´s List - (' + IntToStr(FCountPetNodes)+')');
  end;

  procedure TXMLResourceReader.LoadPet(var ADataList: TList<TXMLPetNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLPetNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'PET_ID' then
            FNode.RMonID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'APPR' then
            FNode.RAppr        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PRICE' then
            FNode.RPrice       := StrToInt64Def(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName        := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'DESC' then
            FNode.RDescription := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_PET' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountPetNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadPet');
    end;
  end;

  procedure TXMLResourceReader.LoadPetExp;
  begin
    LoadPetExp(FPetExpDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Pet Exp List - (' + IntToStr(FCountPetExpNodes)+')');
  end;

  procedure TXMLResourceReader.LoadPetExp(var ADataList: TList<TXMLPetExpNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLPetExpNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'PET_LEVEL' then
            FNode.RPetLevel    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_EXP' then
            FNode.RNeedExp     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAX_SATIS' then
            FNode.RMaxStatis   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DIMI_SATIS' then
            FNode.RDimiStatis  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_PET_EXP' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountPetExpNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadPetExp');
    end;
  end;

  procedure TXMLResourceReader.LoadPetSkill;
  begin
    LoadPetSkill(FPetSkillDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Pet Skills List - (' + IntToStr(FCountPetSkillNodes)+')');
  end;

  procedure TXMLResourceReader.LoadPetSkill(var ADataList: TList<TXMLPetSkillNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLPetSkillNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'PET_SKILL_ID' then
            FNode.RPetSkillID := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SKILL_NAME' then
            FNode.RSkillName  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MAX_VALUE' then
            FNode.RMaxValue   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'GET_LEVEL' then
            FNode.RGetLevel   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'GET_PER' then
            FNode.RGetPer     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'KOR_NAME' then
            FNode.RKoreaName  := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_PET_SKILL' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountPetSkillNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadPetSkill');
    end;
  end;

  procedure TXMLResourceReader.LoadProItems;
  begin
    LoadProItems(FProItemsDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Pro Item List - (' + IntToStr(FCountProItemsNodes)+')');
  end;

  procedure TXMLResourceReader.LoadProItems(var ADataList: TList<TXMLProItemsNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLProItemsNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DESC' then
            FNode.RDescription  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_TYPE' then
            FNode.RItemType     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SORT_NO' then
            FNode.RSortNo       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RARE' then
            FNode.RRare         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COUNT' then
            FNode.RCount        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_AP' then
            FNode.RReqAP        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUCC_RATE' then
            FNode.RSuccessRate  := StrToFloatDef(AXMLNode.attributes.item[I].nodeValue, 0.0);
          if AXMLNode.attributes.item[I].nodeName = 'GET_AEXP' then
            FNode.RGetAExp      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'USE_TIME' then
            FNode.RUseTime      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_PROITEMS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountProItemsNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadProItems');
    end;
  end;

  procedure TXMLResourceReader.LoadQItemDrop;
  begin
    LoadQItemDrop(FQItemDropDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest Drop Item List - (' + IntToStr(FCountQItemDropNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQItemDrop(var ADataList: TList<TXMLQItemDropNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQItemDropNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QITEM_ID' then
            FNode.RQuestItemID  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RATE' then
            FNode.RRate         := StrToFloatDef(AXMLNode.attributes.item[I].nodeValue, 0.0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QITEM_DROP' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQItemDropNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQItemDrop');
    end;
  end;

  procedure TXMLResourceReader.LoadQuest;
  begin
    LoadQuest(FQuestDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest List - (' + IntToStr(FCountQuestNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQuest(var ADataList: TList<TXMLQuestNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQuestNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'STORY_CODE' then
            FNode.RStoryCode    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_TITLE' then
            FNode.RQuestTitle   := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_KIND' then
            FNode.RQuestKind    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'CR_LV' then
            FNode.RCR_Level     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'OPEN_NPC' then
            FNode.ROpenNpcID    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COMP_NPC' then
            FNode.RCompNpcID    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TIME_LIMIT' then
            FNode.RTimeLimit    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PREV_QUEST' then
            FNode.RPrevQuestID  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_LV' then
            FNode.RREQ_LV       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_GENDER' then
            FNode.RReqGender    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_FAME' then
            FNode.RReqFame      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_JOB' then
            FNode.RReqJob       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_PKP' then
            FNode.RReqPKPoints  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REQ_CP' then
            FNode.RReqCP        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NR_EXP' then
            FNode.RNrExp        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NR_FAME' then
            FNode.RNrFame       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NR_GOLD' then
            FNode.RNrGold       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NR_PKP_DECREASE' then
            FNode.RNrPKPDecrease:= StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NR_CP' then
            FNode.RNrCP         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'OPEN_SENTENCE' then
            FNode.ROpenSentence := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'COMP_SENTENCE' then
            FNode.RCompSentence := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'CLEAR_SENTENCE' then
            FNode.RClearSentence:= AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'APPLY_ROW' then
            FNode.RApplyRow     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QUEST' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQuestNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQuest');
    end;
  end;

  procedure TXMLResourceReader.LoadQuestComp;
  begin
    LoadQuestComp(FQuestCompDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest Comps List - (' + IntToStr(FCountQuestCompNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQuestComp(var ADataList: TList<TXMLQuestCompNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQuestCompNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_MARK' then
            FNode.RQuestMark    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MARK_ID' then
            FNode.RMarkID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COUNT' then
            FNode.RCount        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QUEST_COMP' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQuestCompNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQuestComp');
    end;
  end;

  procedure TXMLResourceReader.LoadQuestItem;
  begin
    LoadQuestItem(FQuestItemDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest Item List - (' + IntToStr(FCountQuestItemNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQuestItem(var ADataList: TList<TXMLQuestItemNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQuestItemNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'QITEM_NAME' then
            FNode.RQuestItemName := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QUEST_ITEM' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQuestItemNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQuestItem');
    end;
  end;

  procedure TXMLResourceReader.LoadQuestReaction;
  begin
    LoadQuestReaction(FQuestReactionDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest Reaction List - (' + IntToStr(FCountQuestReactionNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQuestReaction(var ADataList: TList<TXMLQuestReactionNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQuestReactionNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REACTION_NUM' then
            FNode.RReactionNum    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REACTION_TYPE' then
            FNode.RReactionType   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MOVEMAP_NUM' then
            FNode.RMoveMapNum     := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MOVEMAP_X' then
            FNode.RMoveMapX       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MOVEMAP_Y' then
            FNode.RMoveMapY       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUMMON_ID' then
            FNode.RSummonID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUMMON_AMOUNT' then
            FNode.RSummonAmount   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUMMON_STAYTIME' then
            FNode.RSummonStayTime := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUMMON_RADIUS' then
            FNode.RSummonRadius   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QUEST_REACTION' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQuestReactionNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQuestReaction');
    end;
  end;

  procedure TXMLResourceReader.LoadQuestReward;
  begin
    LoadQuestReward(FQuestRewardDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Quest Reward List - (' + IntToStr(FCountQuestRewardNodes)+')');
  end;

  procedure TXMLResourceReader.LoadQuestReward(var ADataList: TList<TXMLQuestRewardNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLQuestRewardNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'QUEST_ID' then
            FNode.RQuestID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REWARD_TYPE' then
            FNode.RRewardType   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COUNT' then
            FNode.RCount        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_QUEST_REWARD' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountQuestRewardNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadQuestReward');
    end;
  end;

  procedure TXMLResourceReader.LoadRandomBox;
  begin
    LoadRandomBox(FRandomBoxDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Random Box List - (' + IntToStr(FCountRandomBoxNodes)+')');
  end;

  procedure TXMLResourceReader.LoadRandomBox(var ADataList: TList<TXMLRandomBoxNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLRandomBoxNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'USE_ITEM_ID' then
            FNode.RUseItemID      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDJOB' then
            FNode.RNeedJob        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_LV_MIN' then
            FNode.RNeedMinLevel   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_LV_MAX' then
            FNode.RNeedMaxLevel   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_ITEM_1' then
            FNode.RNeedItem_1     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_ITEM_2' then
            FNode.RNeedItem_2     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED_ITEM_3' then
            FNode.RNeedItem_3     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PERCENT' then
            FNode.RPercent        := StrToFloatDef(AXMLNode.attributes.item[I].nodeValue, 0.0);
          if AXMLNode.attributes.item[I].nodeName = 'REWARD_ITEM_ID' then
            FNode.RRewardItemID   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REWARD_USETIME' then
            FNode.RRewardUseTime  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REWARD_AMOUNT' then
            FNode.RRewardAmount   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_RANDOMBOX' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountRandomBoxNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadRandomBox');
    end;
  end;

  procedure TXMLResourceReader.LoadRareItems;
  begin
    LoadRareItems(FRareItemsDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Rare Items List - (' + IntToStr(FCountRareItemsNodes)+')');
  end;

  procedure TXMLResourceReader.LoadRareItems(var ADataList: TList<TXMLRareItemsNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLRareItemsNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'UPGPROB' then
            FNode.RUPGProb        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DROPHOUR' then
            FNode.RDropHour       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_RAREITEMS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountRareItemsNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadRareItems');
    end;
  end;

  procedure TXMLResourceReader.LoadStartPoint;
  begin
    LoadStartPoint(FStartPointDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Start Point List - (' + IntToStr(FCountStartPointNodes)+')');
  end;

  procedure TXMLResourceReader.LoadStartPoint(var ADataList: TList<TXMLStartPointNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLStartPointNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_X' then
            FNode.RMapX           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_Y' then
            FNode.RMapY           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_STARTPOINT' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountStartPointNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadStartPoint');
    end;
  end;

  procedure TXMLResourceReader.LoadStdItems;
  begin
    LoadStdItems(FStdItemsDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Std Items List - (' + IntToStr(FCountStdItemsNodes)+')');
  end;

  procedure TXMLResourceReader.LoadStdItems(var ADataList: TList<TXMLStdItemsNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLStdItemsNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ITEM_ID' then
            FNode.RItemID         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RItemName       := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'STDMODE' then
            FNode.RStdMode        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SHAPE' then
            FNode.RShape          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'WEIGHT' then
            FNode.RWeight         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'CHARLOOKS' then
            FNode.RCharLooks      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ANICOUNT' then
            FNode.RAniCount       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SOURCE' then
            FNode.RSource         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RESERVED' then
            FNode.RReserved       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EXPIRING' then
            FNode.RExpiring       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDFAME' then
            FNode.RNeedFame       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'THROW' then
            FNode.RThrow          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'LOOKS' then
            FNode.RLooks          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DURAMAX' then
            FNode.RDuraMax        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AC' then
            FNode.RAC             := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AC2' then
            FNode.RAC2            := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC_TYPE' then
            FNode.RMacType        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC' then
            FNode.RMac            := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAC2' then
            FNode.RMac2           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'A_ATOM_GOOD' then
            FNode.RAAtomGood      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'A_ATOM_BAD' then
            FNode.RAAtomBad       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DC_MIN' then
            FNode.RDCMin          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DC_MAX' then
            FNode.RDCMax          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_TYPE' then
            FNode.RMcType         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_MIN' then
            FNode.RMCMin          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MC_MAX' then
            FNode.RMCMax          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'W_ATOM' then
            FNode.RWAtom          := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'W_ATOM_VAL' then
            FNode.RWAtomValue     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FUNC_TYPE' then
            FNode.RFuncType       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEED' then
            FNode.RNeed           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDLEVEL' then
            FNode.RNeedLevel      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NEEDJOB' then
            FNode.RNeedJob        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'PRICE' then
            FNode.RPrice          := StrToInt64Def(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'STOCK' then
            FNode.RStock          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'KORNAME' then
            FNode.RKoreaName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ACCUR' then
            FNode.RAccur          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ATSPEED' then
            FNode.RATSpeed        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SPSPEED' then
            FNode.RSPSpeed        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AGILITY' then
            FNode.RAgility        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAGICEVADE' then
            FNode.RMagiceVade     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'COMFORT' then
            FNode.RComfort        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EQUIPWEIGHT' then
            FNode.REquipWeight    := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HANDLEWEIGHT' then
            FNode.RHandleWeight   := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'BAGWEIGHT' then
            FNode.RBagWeight      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'HP' then
            FNode.RHP             := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MP' then
            FNode.RMP             := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DETAIL' then
            FNode.RDetail         := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'REDC' then
            FNode.RRedc           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAGICCATE' then //category?
            FNode.RMagicCate      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REMAGIC' then
            FNode.RReMagic        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TRANSLV' then
            FNode.RTransLevel     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'UNDETACHABLE' then
            FNode.RUndetachable   := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'BELONGING' then
            FNode.RBelonging      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SETNO' then
            FNode.RSetNo          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SETINDEX' then
            FNode.RSetIndex       := StrToInt64Def(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DIEOUT' then
            FNode.RDieOut         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'DROPOUT' then
            FNode.RDropOut        := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'GUILDOWNER' then
            FNode.RGuildOwner     := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'INTERNETCAFE' then
            FNode.RInternetCafe   := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'GROUP' then
            FNode.RGroup          := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'MAXQTY' then
            FNode.RMaxQuality     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REFINE' then
            FNode.RRefine         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'DROP' then
            FNode.RDrop           := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'LUCKY' then
            FNode.RLucky          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DESTRUCTION' then
            FNode.RDestruction    := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'SCALE' then
            FNode.RScale          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'EFFECTID' then
            FNode.REffectID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RATIO_TYPE' then
            FNode.RRatioType      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'RATIO' then
            FNode.RRatio             := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'REPAIR_ABLE' then
            FNode.RRepairable        := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'SREPAIR_ABLE' then
            FNode.RSRepairable       := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'MARRIAGE' then
            FNode.RMarriage          := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'RESURRECTION_RATIO' then
            FNode.RResurrectionRatio := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'SUCCESS_RATIO' then
            FNode.RSuccessRatio      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'METHOD_RARE' then
            FNode.RMethodRare        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TAOIST_SKILL_RATIO' then
            FNode.RTaoistSkillRatio  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'TRADE_USER' then
            FNode.RTradeUser         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'TRADE_SHOP' then
            FNode.RTradeShop         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'TRADE_ENTRUST' then
            FNode.RTradeEntrust      := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_STDITEMS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountStdItemsNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadStdItems');
    end;
  end;

  procedure TXMLResourceReader.LoadStringS;
  begin
    LoadStringS(FStringSDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Strings List - (' + IntToStr(FCountStringSNodes)+')');
  end;

  procedure TXMLResourceReader.LoadStringS(var ADataList: TList<TXMLStringSNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLStringSNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ID' then
            FNode.RStringID       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'STRING_TEXT' then
            FNode.RText           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'TYPE' then
            FNode.RType           := AXMLNode.attributes.item[I].nodeValue;
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_STRING_S' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountStringSNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadStringS');
    end;
  end;

  procedure TXMLResourceReader.LoadUNpc;
  begin
    LoadUNpc(FUNpcDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read U-NPC List - (' + IntToStr(FCountUNpcNodes)+')');
  end;

  procedure TXMLResourceReader.LoadUNpc(var ADataList: TList<TXMLUNpcNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLUNpcNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'NPC_ID' then
            FNode.RNpcID          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'NAME' then
            FNode.RName           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ROLE' then
            FNode.RRole           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'LINK' then
            FNode.RLink           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_X' then
            FNode.RMapX           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_Y' then
            FNode.RMapY           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FACE' then
            FNode.RFace           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'BODY' then
            FNode.RBody           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'APPLY_ROW' then
            FNode.RApplyRow       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_UNPC' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountUNpcNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadUNpc');
    end;
  end;

  procedure TXMLResourceReader.LoadMonGen;
  begin
    LoadMonGen(FMonGenDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Monster Gen List - (' + IntToStr(FCountMonGenNodes)+')');
  end;

  procedure TXMLResourceReader.LoadMonGen(var ADataList: TList<TXMLMonGenNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLMonGenNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'MAP_ID' then
            FNode.RMapID          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_X' then
            FNode.RMapX           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MAP_Y' then
            FNode.RMapY           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MON_ID' then
            FNode.RMonID          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'MON_CLASS_ID' then
            FNode.RMonClassID     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'DROPSET' then
            FNode.RDropSet        := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'RANGE' then
            FNode.RRange          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'AMOUNT' then
            FNode.RAmount         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'GENTIME' then
            FNode.RGenTime        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'CONPERCENT' then
            FNode.RConPercent     := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'ZONELEVEL' then
            FNode.RZoneLevel      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'VER' then
            FNode.RVersion        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_MONGEN' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonGenNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadMonGen');
    end;
  end;

  procedure TXMLResourceReader.LoadSaleItems;
  begin
    LoadSaleItems(FSaleItemsDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Sales Items List - (' + IntToStr(FCountSaleItemsNodes)+')');
  end;

  procedure TXMLResourceReader.LoadSaleItems(var ADataList: TList<TXMLSaleItemsNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLSaleItemsNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'FLD_TEMP' then
            FNode.RTemp           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_IDENTIFIER' then
            FNode.RIdentifer      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_CATEGORY' then
            FNode.RCategory       := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_HEADER' then
            FNode.RHeader         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_NAME' then
            FNode.RName           := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_INDEX' then
            FNode.RIndex          := StrToInt64Def(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DURA' then
            FNode.RDura           := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DURAMAX' then
            FNode.RDuraMax        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC0' then
            FNode.RDesc0          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC1' then
            FNode.RDesc1          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC2' then
            FNode.RDesc2          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC3' then
            FNode.RDesc3          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC4' then
            FNode.RDesc4         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC5' then
            FNode.RDesc5          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC6' then
            FNode.RDesc6          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC7' then
            FNode.RDesc7          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC8' then
            FNode.RDesc8          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC9' then
            FNode.RDesc9          := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC10' then
            FNode.RDesc10         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC11' then
            FNode.RDesc11         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC12' then
            FNode.RDesc12         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DESC13' then
            FNode.RDesc13         := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_COLORR' then
            FNode.RColor_R        := Byte(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'FLD_COLORG' then
            FNode.RColor_G        := Byte(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'FLD_COLORB' then
            FNode.RColor_B        := Byte(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'FLD_QTY' then
            FNode.RQuality        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_PERMITPERIOD' then
            FNode.RPermitPeriode  := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_SALEPRICE' then
            FNode.RSalePrice      := StrToInt64Def(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'FLD_KORNAME' then
            FNode.RKoreaName      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_SALESTARTDATE' then
            FNode.RSaleStartDate  := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_SALEENDDATE' then
            FNode.RSaleEndTime    := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_NOSELL' then
            FNode.RNoSell         := Boolean(StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0));
          if AXMLNode.attributes.item[I].nodeName = 'FLD_DETAIL' then
            FNode.RDetail         := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'FLD_BUFF_IMG' then
            FNode.RBuffImage      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_SALEITEMS' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountSaleItemsNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadSaleItems');
    end;
  end;

  procedure TXMLResourceReader.LoadAdminList;
  begin
    LoadAdminList(FAdminListDataList);
    FrmMain.lbServerMessage.Items.Add('[XML] - Read Admin List - (' + IntToStr(FCountAdminListNodes)+')');
  end;

  procedure TXMLResourceReader.LoadAdminList(var ADataList: TList<TXMLAdminListNode>);

    procedure ProcessNode(AXMLNode: IDOMNode);
    var
      I     : Integer;
      FNode : TXMLAdminListNode;
    begin
      if AXMLNode.NodeName = 'VALUE' then
      begin
        for I := 0 to AXMLNode.attributes.length-1 do
        begin
          if AXMLNode.attributes.item[I].nodeName = 'ADMIN_ID' then
            FNode.RAdminID        := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
          if AXMLNode.attributes.item[I].nodeName = 'USER_NAME' then
            FNode.RDBUserID       := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ADMIN_ROLE' then
            FNode.RAdminRole      := AXMLNode.attributes.item[I].nodeValue;
          if AXMLNode.attributes.item[I].nodeName = 'ROLE_LEVEL' then
            FNode.RRoleLevel      := StrToIntDef(AXMLNode.attributes.item[I].nodeValue, 0);
        end;
      end;
      ADataList.Add(FNode);
    end;

  var
    I          : Integer;
    FXMLNode   : IDOMNode;
    FXMLNodeEx : IDOMNode;
  begin
    try
      FXMLDomNode := FXMLDomDoc.documentElement.DOMNode;
      FXMLNode    := FXMLDomNode.firstChild;
      while Assigned(FXMLNode) do
      begin
        if FXMLNode.NodeName = 'RES_ADMIN_LIST' then
        begin
          for I := 0 to FXMLNode.childNodes.length-1 do
          begin
            FXMLNodeEx := FXMLNode.childNodes.item[I];
            ProcessNode(FXMLNodeEx);
            Inc(FCountMonGenNodes);
          end;
          Break;
        end;
        FXMLNode := FXMLNode.NextSibling;
      end;
    except
      ServerLogMessage('Exception] - XMLResourceReader::LoadAdminList');
    end;
  end;

  function TXMLResourceReader.GetMonsterNameByID(const AIndex: Integer): String;
  var
    I: Integer;
  begin
    for I := 0 to FMonsterDataList.Count-1 do
    begin
      if AIndex = FMonsterDataList.Items[I].RMonID then
      begin
        Result := FMonsterDataList.Items[I].RName;
        Break;
      end;
    end;
  end;

  function TXMLResourceReader.GetStdItemNameByID(const AIndex: Integer): String;
  var
    I: Integer;
  begin
    for I := 0 to FStdItemsDataList.Count-1 do
    begin
      if AIndex = FStdItemsDataList.Items[I].RItemID then
      begin
        Result := FStdItemsDataList.Items[I].RItemName;
        Break;
      end;
    end;
  end;

  function TXMLResourceReader.GetMapNameByID(const AIndex: Integer): String;
  var
    I: Integer;
  begin
    for I := 0 to FMapInfoDataList.Count-1 do
    begin
      if AIndex = FMapInfoDataList.Items[I].RMapID then
      begin
        Result := FMapInfoDataList.Items[I].RMapName;
        Break;
      end;
    end;
  end;

{$ENDREGION}



initialization
  GXMLResourceReader := TXMLResourceReader.Create;

finalization
  FreeAndNil(GXMLResourceReader);

end.
